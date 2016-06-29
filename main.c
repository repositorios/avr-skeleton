#ifndef F_CPU
    #define F_CPU 16000000UL // 16 MHz clock speed
#endif

#include <avr/io.h>
#include <util/delay.h>

#define set_bit(Y,bit_x) (Y |= (1<<bit_x))
#define clr_bit(Y,bit_x) (Y &= ~(1<<bit_x))
#define tst_bit(Y,bit_x) (Y & (1<<bit_x)) 
#define cpl_bit(Y,bit_x) (Y ^= (1<<bit_x))

int main( ) {
    
    DDRB = 0xFF;
    while(1) {
        set_bit(PORTB, PB5);
        _delay_ms(1000);
        clr_bit(PORTB, PB5);
        _delay_ms(1000);
    }
}
