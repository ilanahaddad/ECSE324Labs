#ifndef __HPS_TIM
#define __HPS_TIM

	typedef enum {
		TIM0 = 0x00000001,
		TIM1 = 0x00000002,
		TIM2 = 0x00000004,
		TIM3 = 0x00000008
	}	HPS_TIM_t;

	typedef struct {
		HPS_TIM_t tim;
		int timeout; // in usec (microseconds)
		int LD_en; //set to 1 to be enabled and 0 to be disabled
		int INT_en;
		int enable;
	}	HPS_TIM_config_t;

    /*Note: The argument is a struct pointer
     ex: timeout element can be accessed in the assembly subroutine
     via a load instruction from the address in R0 offset by 0x4*/
	extern void HPS_TIM_config_ASM(HPS_TIM_config_t *param);

    /*Read the value of the S-bit (offset = 0x10)
     The nature of the return value will depend on whether this function
     is able to read the S-bit value of mulitple timers in the same call*/
    /*The return value is an integer that should be interpreted as a 4-bit one-hot
     encoded number, with bit 0 corresponding to the S-bit of TIM0 and so on*/
	extern int HPS_TIM_read_INT_ASM(HPS_TIM_t tim);
        /*this function can be used to read the S-bit of just one timer or
            can also be used to read hte S-bit of all 4 timers*/

    /*Resets the S-bit and the F-bit
     This function should support multiple times in the argument */
	extern void HPS_TIM_clear_INT_ASM(HPS_TIM_t tim);

#endif
