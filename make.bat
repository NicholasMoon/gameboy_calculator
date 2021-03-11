rgbasm -o gb_calculator.o gb_calculator.asm
rgblink -o calculator.gb gb_calculator.o
rgbfix -v -p 0 calculator.gb