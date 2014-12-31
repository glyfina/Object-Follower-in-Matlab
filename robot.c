
microcontroller: ATmega-8
clock: 12mhz
compiler WinAVR-20100110
********************************************************************************/

#include<avr/io.h>
#define F_CPU 12000000
#include <util/delay.h> 
#include "uart.h"

int main(void)
{
	unsigned char data;
	DDRB=0x0F;					//data direction for LED
	DDRD=0xF0;					//data direction for motor
	uart_init();				//Initialization of UART
	
	_delay_ms(100);
 while(1)
  {
	data=uart_read();			//read a charactor from UART
	switch (data)
	 {
              case'a':
               PORTB=0X0F;
                  break;
	  case 'f':					//if received 1
	   PORTB=0x01;				//glow LED0
	   PORTD=0x50;        // move forward
	   break; 
	  case 'b':					//if received 2
	   PORTB=0x02;				//glow LED1	
	   PORTD=0xA0;        // move backward
	   break; 
	  case 'l':					//if received 3
	   PORTB=0x04;				//glow LED2
	  PORTD=0x01;         // move left
	   break; 					
	  case 'r':					//if received 4
	   PORTB=0x08;				//glow LED3
	   PORTD=0x40;       // move right
	   break;  
	  case 's':					//if received 5
	   PORTB=0x00;				//glow all LED
	   PORTD=0x00;
	   break;  
	  }
	
  }
 }
  
