#include <stdio.h>
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"


int main(){
	int count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
	
	HPS_TIM_config_t t0;
	t0.tim = TIM0;
	t0.timeout = 10000;	
	t0.LD_en = 0;
	t0.INT_en = 0;
	t0.enable = 0;
	HPS_TIM_config_ASM(&t0);

	HPS_TIM_config_t poll;
	poll.tim = TIM1;
	poll.timeout = 1000000;	
	poll.LD_en = 1;
	poll.INT_en = 1;
	poll.enable = 1;
	HPS_TIM_config_ASM(&poll);
	int pollCount = 0;

//PB_clear_edgecp_ASM
	while(1){
		if(HPS_TIM_read_INT_ASM(poll.tim)){
			HPS_TIM_clear_INT_ASM(poll.tim);
				int button = read_PB_edgecap_ASM();
				if(button >=1){
					if(PB_edgecap_is_pressed_ASM(PB0)){
						t0.LD_en = 1;
						t0.INT_en = 1;
						t0.enable = 1;
						HPS_TIM_config_ASM(&t0);
					}
					if(PB_edgecap_is_pressed_ASM(PB2)){
						t0.LD_en = 0;
						t0.INT_en = 0;
						t0.enable = 0;
						HPS_TIM_config_ASM(&t0);
						if(HPS_TIM_read_INT_ASM(t0.tim) == 0){
							HEX_flood_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);				
						}
						count0 = 0, count1=0,count2=0,count3=0,count4=0,count5=0;
					}

					if(PB_edgecap_is_pressed_ASM(PB1)){
						t0.LD_en = 0;
						t0.INT_en = 0;
						t0.enable = 0;
						HPS_TIM_config_ASM(&t0);
					}
					PB_clear_edgecp_ASM(15);
				}
			}
				if(HPS_TIM_read_INT_ASM(t0.tim)){
					HPS_TIM_clear_INT_ASM(t0.tim);
					if(++count0 == 10){
						count0 = 0;
						if(++count1==10){
							count1=0;
							if(++count2==10){
								count2=0;
								if(++count3==10){
									count3=0;
									if(++count4==10){
										count4 = 0;
										if(++count5==10){
											count5=0;
										}
									}
								}
							}
						}
					}
					HEX_write_ASM(HEX5,count5);
					HEX_write_ASM(HEX4,count4);
					HEX_write_ASM(HEX3,count3);
					HEX_write_ASM(HEX2,count2);
					HEX_write_ASM(HEX1,count1);
					HEX_write_ASM(HEX0,count0);
				}
			}
	return 0;
}
