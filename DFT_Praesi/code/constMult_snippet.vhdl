for i in 0 to 7 loop
    constMult_long(i*8)   := my_const*input_real(1)(i);
    constMult_long(i*8+1) := my_const*input_imag(1)(i);
    constMult_long(i*8+2) := my_const*input_real(3)(i);
    constMult_long(i*8+3) := my_const*input_imag(3)(i);
    constMult_long(i*8+4) := my_const*input_real(5)(i);
    constMult_long(i*8+5) := my_const*input_imag(5)(i);
    constMult_long(i*8+6) := my_const*input_real(7)(i);
    constMult_long(i*8+7) := my_const*input_imag(7)(i);
end loop;
            
for j in 0 to 63 loop
    constMult(j) <= constMult_long(j)(bit_width_extern-1 downto 0);
end loop;