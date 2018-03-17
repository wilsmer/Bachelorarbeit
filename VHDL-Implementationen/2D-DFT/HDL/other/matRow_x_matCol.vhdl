function matRow_x_mat_col(twiddle : t_2d_array, input : t_2d_array, i : integer, j : integer) return t_2d_array is 

  variable mult_temp1       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp1_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp2       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp2_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp3       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp3_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp4       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp4_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp5       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp5_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp6       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp6_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp7       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp7_short : unsigned(bit_width_adder-1)      := (others => '0');
  variable mult_temp8       : unsigned(bit_width_multiplier-1) := (others => '0');
  variable mult_temp8_short : unsigned(bit_width_adder-1)      := (others => '0');

  begin
    mult_temp1       := twiddle(0)(0) * input(0)(0);
    mult_temp1_short := mult_temp1(bit_width_adder-1 downto 0);
    mult_temp2       := twiddle(0)(1) * input(1)(0);
    mult_temp2_short := mult_temp2(bit_width_adder-1 downto 0);
    mult_temp3       := twiddle(0)(2) * input(2)(0);
    mult_temp3_short := mult_temp3(bit_width_adder-1 downto 0);
    mult_temp4       := twiddle(0)(3) * input(3)(0);
    mult_temp4_short := mult_temp4(bit_width_adder-1 downto 0);
    mult_temp5       := twiddle(0)(4) * input(4)(0);
    mult_temp5_short := mult_temp5(bit_width_adder-1 downto 0);
    mult_temp6       := twiddle(0)(5) * input(5)(0);
    mult_temp6_short := mult_temp6(bit_width_adder-1 downto 0);
    mult_temp7       := twiddle(0)(6) * input(6)(0);
    mult_temp7_short := mult_temp7(bit_width_adder-1 downto 0);
    mult_temp8       := twiddle(0)(7) * input(7)(0);
    mult_temp8_short := mult_temp8(bit_width_adder-1 downto 0);
            
    val1 <= twiddle(i)(0) * input(0)(i) + 
            twiddle(i)(1) * input(1)(i) + 
            twiddle(i)(2) * input(2)(i) + 
            twiddle(i)(3) * input(3)(i) + 
            twiddle(i)(4) * input(4)(i) + 
            twiddle(i)(5) * input(5)(i) + 
            twiddle(i)(6) * input(6)(i) + 
            twiddle(i)(7) * input(7)(i);
            
    val2 <= twiddle(i)(0) * input(0)(i) + 
            twiddle(i)(1) * input(1)(i) + 
            twiddle(i)(2) * input(2)(i) + 
            twiddle(i)(3) * input(3)(i) + 
            twiddle(i)(4) * input(4)(i) + 
            twiddle(i)(5) * input(5)(i) + 
            twiddle(i)(6) * input(6)(i) + 
            twiddle(i)(7) * input(7)(i);

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
    mat_mult : process(clk)
      
      variable mult_temp  : unsigned(bit_width_multiplier-1 downto 0) := (others => '0');
      variable mult_short : unsigned(bit_width_adder-1 downto 0) := (others => '0');
      variable add_temp   : unsigned(bit_width_adder-1 downto 0) := "0000000000000";
      variable dft_temp   : t_2d_array;
      variable ctr        : unsigned(8 downto 0) := (others => '0');
      variable i, j, m    : integer;
        
      begin
        if clk='1' and clk'event then
          if loaded='1' and ctr<(mat_size)*(mat_size)*(mat_size)-1 then
            
            i   := conv_integer(ctr(8 downto 6));
            j   := conv_integer(ctr(5 downto 3));
            m   := conv_integer(ctr(2 downto 0));
            ctr := ctr+1;
            
            i_out <= ctr(8 downto 6);
            j_out <= ctr(5 downto 3);
            m_out <= ctr(2 downto 0);
                          
            mult_temp  := twiddle(i)(m) * input(m)(i);    -- 12Bit * 12Bit = 24Bit
            mult_short := '0'&mult_temp(bit_width_extern-1 downto 0);
            
            add_temp   := add_temp + mult_short;
            add_temp(add_temp'high) := '0'; -- MSB '0' setzen
                
            mult_res_out <= mult_temp after 10 ns;    
            summation <= add_temp after 13 ns;
            
            dft_temp(i)(j) := add_temp(bit_width_adder-2 downto 0);
            add_temp := (others => '0');
          end if;
        end if;
        dft <= dft_temp;
      end process;
