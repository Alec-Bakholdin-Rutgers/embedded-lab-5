

#include "xtmrctr.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "xil_printf.h"

/* Hardware-related constants */
#define TMRCTR_DEVICE_ID        XPAR_TMRCTR_0_DEVICE_ID
#define TMRCTR_INTERRUPT_ID     XPAR_FABRIC_TMRCTR_0_VEC_ID

#define INTC_DEVICE_ID          XPAR_SCUGIC_SINGLE_DEVICE_ID
#define INTC                    XScuGic
#define INTC_HANDLER            XScuGic_InterruptHandler

#define TMRCTR_0				0
#define TMRCTR_1				1


/* Functional constants that affect the program */
#define PWM_PERIOD				(u32)5e6
#define CYCLES_PER_STEP			10
#define STEPS_PER_PULSE			10
#define WAIT_COUNT				PWM_PERIOD


/* Function definitions */
static void TmrCtrInit(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 DeviceId, u16 IntrId);
static void TmrCtrSetupInterrupt(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 DeviceId, u16 IntrId);
static void TmrCtrDisable(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 IntrId);

int TmrCtrPwm(XTmrCtr *TmrCtrInstancePtr);
static void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber);


/* Variables */
INTC InterruptController;
XTmrCtr TimerCounterInst;

static int   PeriodTimerHit = FALSE;
static int   HighTimerHit = FALSE;

int main(void) {
	int Status;

	xil_printf("Initializing timer and setting up interrupt handler\n");
	TmrCtrInit(&InterruptController, &TimerCounterInst, TMRCTR_DEVICE_ID, TMRCTR_INTERRUPT_ID);

	xil_printf("Executing code...\n");
	Status = TmrCtrPwm(&TimerCounterInst);
	if(Status != XST_SUCCESS) {
		xil_printf("ERROR!\n");
	} else {
		xil_printf("Successfully executed code\n");
	}

	xil_printf("Disabling Timer\n");
	TmrCtrDisable(&InterruptController, &TimerCounterInst, TMRCTR_INTERRUPT_ID);

	xil_printf("Done\n");
}


int TmrCtrPwm(XTmrCtr *TmrCtrInstancePtr) {
		u32 NoOfCycles;
		u32 Step;
		u32 Period;
		u32 HighTime;
		u64 WaitCount;
		float HighTimeFactor;
		int Status = XST_SUCCESS;

		Step = 1;

		/* Configure PWM */
		while(1){

			if (Step >= STEPS_PER_PULSE) {
				Step = 1;
			}

			/* Disable PWM for reconfiguration */
			XTmrCtr_PwmDisable(TmrCtrInstancePtr);

			/* Configure PWM */
			Period = PWM_PERIOD;
			HighTimeFactor = (float)Step/(float)STEPS_PER_PULSE;
			HighTime = HighTimeFactor*(float)PWM_PERIOD;
			XTmrCtr_PwmConfigure(TmrCtrInstancePtr, Period,
									HighTime);

			Step++;
			if (Status != XST_SUCCESS) {
				Status = XST_FAILURE;
				goto err;
			}

			/* Enable PWM */
			XTmrCtr_PwmEnable(TmrCtrInstancePtr);

			NoOfCycles = 0;
			WaitCount = WAIT_COUNT;
			while (NoOfCycles < CYCLES_PER_STEP) {
				if (PeriodTimerHit == TRUE && HighTimerHit == TRUE) {
					PeriodTimerHit = FALSE;
					HighTimerHit = FALSE;
					WaitCount = WAIT_COUNT;
					NoOfCycles++;
				}

				/* Interrupt did not occur as expected */
				if (!(--WaitCount)) {
					return XST_FAILURE;
				}
			}
		}

		Status = XST_SUCCESS;
	err:

		return Status;
}

static void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	/* Mark if period timer expired */
	if (TmrCtrNumber == TMRCTR_0) {
		PeriodTimerHit = TRUE;
	}

	/* Mark if high time timer expired */
	if (TmrCtrNumber == TMRCTR_1) {
		HighTimerHit = TRUE;
	}
}


static void TmrCtrInit(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 DeviceId, u16 IntrId) {
	// initialize timer and attach interrupt handler
	XTmrCtr_Initialize(TmrCtrInstancePtr, DeviceId);
	TmrCtrSetupInterrupt(IntcInstancePtr, TmrCtrInstancePtr, DeviceId, IntrId);
	XTmrCtr_SetHandler(TmrCtrInstancePtr, TimerCounterHandler, TmrCtrInstancePtr);

	// enable interrupt for each timer counter
	XTmrCtr_SetOptions(TmrCtrInstancePtr, TMRCTR_0, XTC_INT_MODE_OPTION);
	XTmrCtr_SetOptions(TmrCtrInstancePtr, TMRCTR_1, XTC_INT_MODE_OPTION);
}


static void TmrCtrSetupInterrupt(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 DeviceId, u16 IntrId) {
	XScuGic_Config *IntcConfig;

	// lookup and initialize config; attach it to the interrupt controller
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig, IntcConfig->CpuBaseAddress);

	// set priority and trigger type of interrupt
	XScuGic_SetPriorityTriggerType(IntcInstancePtr, IntrId, 0xA0, 0x3);

	// connect interrupt to the timer, tell the processor which interrupt handler to use(found in xtmrctr.h)
	XScuGic_Connect(IntcInstancePtr, IntrId, (Xil_ExceptionHandler)XTmrCtr_InterruptHandler, TmrCtrInstancePtr);
	XScuGic_Enable(IntcInstancePtr, IntrId);

	// register and initialize exception table
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)INTC_HANDLER, IntcInstancePtr);
	Xil_ExceptionEnable();
}


static void TmrCtrDisable(INTC *IntcInstancePtr, XTmrCtr *TmrCtrInstancePtr, u16 IntrId) {
	XTmrCtr_PwmDisable(TmrCtrInstancePtr);
	XScuGic_Disconnect(IntcInstancePtr, IntrId);
}
