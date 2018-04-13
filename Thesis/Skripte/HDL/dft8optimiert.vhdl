library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
library work;
use work.all;
use datatypes.all;
use constants.all;


library STD; 	-- for reading text file 
use STD.TEXTIO.ALL; 
use ieee.std_logic_textio.all;

entity dft8optimiert is
port(
     clk           : in  bit;
     nReset        : in  bit;
     loaded        : in  bit;
     input_real    : in  t_2d_array;
     input_imag    : in  t_2d_array;
     result_real   : out t_2d_array;
     result_imag   : out t_2d_array;
     result_ready  : out bit;
     idft          : in  bit;
     state_out     : out t_dft8_states;
     element_out   : out unsigned(5 downto 0);
     dft_1d_2d_out : out bit
    );
end dft8optimiert;


architecture arch of dft8optimiert is
  
  signal dft_state, next_dft_state : t_dft8_states;  
  
  
begin

  FSM_TAKT: process(clk)
  begin
    if clk='1' and clk'event then
      dft_state <= dft_state;
      state_out <= dft_state;
      if nReset='0' then
        dft_state <= idle;
        state_out <= idle;
      elsif loaded = '0' then
        dft_state <= idle;
        state_out <= idle;
      elsif loaded='1' and dft_state = idle then
        dft_state <= twiddle_calc;
        state_out <= twiddle_calc;
      else
        dft_state <= next_dft_state;
        state_out <= next_dft_state;
      end if;
    end if;
  end process;

  
  FSM_KOMB: process(dft_state)
    --constant twiddle_coeff : signed(16 downto 0) := "00010110101000001";
    variable twiddle_coeff : signed(bit_width_adder-1 downto 0);
    
    variable mult_re, mult_im : signed(bit_width_multiplier-1 downto 0);
    
    variable W_row, I_col : integer;
    variable dft_1d_real, dft_1d_imag : t_2d_array;
    variable matrix_real, matrix_imag : t_2d_array;
    variable temp_re, temp_im : t_1d_array6_13bit;
    variable temp14bit_re, temp14bit_im : signed(bit_width_adder downto 0);
    variable dft_1d_2d   : bit;
    variable element     : unsigned(5 downto 0) := "000000";
    
    
    variable row_col_idx : integer := 0;
    
    --variable LineBuffer : LINE;
                  

  begin  
    twiddle_coeff := "0001011010100";
    -- Flip-Flops
       -- werden das 1. Mal sich selbst zu gewiesen, bevor sie einen Wert haben!
    result_ready <= '0';
    element      := element;
    dft_1d_2d    := dft_1d_2d;
    temp_re      := temp_re;
    temp_im      := temp_im;
    mult_re      := mult_re;
    mult_im      := mult_im;
    dft_1d_real  := dft_1d_real;
    dft_1d_imag  := dft_1d_imag;
    matrix_real  := matrix_real;
    matrix_imag  := matrix_imag;
    dft_1d_2d_out <= dft_1d_2d;
    
    
    -- Die Matrix hat 64 Elemente -> 2^6=64 -> 6-Bit Vektor passt genau. Ueberlauf = 1. Element vom naechsten Durchlauf. 
    -- Der Elemente-Vektor kann darueber hinaus in vordere Haelfte = Zeile und hintere Haelfte = Spalte augeteilt werden. 
    -- So laesst sich auch ein Matrix-Element mit zwei Indizes ansprechen:
    
    -- Bei der IDFT sind die Zeilen 1 und 7, 2 und 6, 3 und 5 vertauscht. 1 und 4 bleiben wie sie sind.
    
    row_col_idx := to_integer(element(5 downto 3)); -- Wird bei der Twiddlefaktor-Matrix als Zeilen-, bei der Zwischen- und 
                                                    -- Ausgangsmatrix als Spaltenindex verwendet. 
    
    if idft = '1' then
      if row_col_idx = 0 then
        W_row := 0;
      else
        W_row := 8-row_col_idx;  -- Twiddlefaktor-Matrix
      end if;
    else
      W_row := row_col_idx;  -- Twiddlefaktor-Matrix
    end if;
    
    I_col := to_integer(element(2 downto 0));  -- Input-Matrix
    
       
    if element = "000000" then
      if dft_1d_2d = '0' then
        matrix_real := input_real;
        matrix_imag := input_imag;
      else
        matrix_real := dft_1d_real;
        matrix_imag := dft_1d_imag;
      end if;
    end if;

    
    case dft_state is
      when idle =>
        next_dft_state <= twiddle_calc;
    
      when twiddle_calc =>  -- dft_state_out = 1
        -- Mit resize werden die 12 Bit Eingangswerte vorzeichengerecht auf 13 Bit erweitert, um um die richtige Groesse zu haben.
        -- Bei der Addition muessen die Summanden die gleiche Bit-Breite wie der Ergebnis-Vektor haben.
        case W_row is
          -- Die Faktoren (Koeffizienten) der Twiddlefaktor-Matrix W lassen sich ueber exp(-i*2*pi*[0:7]'*[0:7]/8) berechnen.
          -- 1. Zeile aus W -> nur Additionen
          when 0 =>
              -- Die 1. Zeile aus W besteht nur aus den Faktoren (1+j0). Daraus resultiert, dass die rellen
              -- und die imaginaeren Werte der Eingangs-Matrix unabhaengig von einander aufsummiert werden.
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) + resize(matrix_real(1)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_real(2)(I_col), bit_width_adder) + resize(matrix_real(3)(I_col), bit_width_adder);
              temp_re(2) := resize(matrix_real(4)(I_col), bit_width_adder) + resize(matrix_real(5)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_real(6)(I_col), bit_width_adder) + resize(matrix_real(7)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) + resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_imag(2)(I_col), bit_width_adder) + resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_im(2) := resize(matrix_imag(4)(I_col), bit_width_adder) + resize(matrix_imag(5)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_imag(6)(I_col), bit_width_adder) + resize(matrix_imag(7)(I_col), bit_width_adder);

              
          -- 2. Zeile aus W besteht aus den Faktoren 
          -- 0: ( 1.00000 + 0.00000i), 1: ( 0.70711 + 0.70711i), 2: (0.00000 + 1.00000i), 3: (-0.70711 + 0.70711i),
          -- 4: (-1.00000 + 0.00000i), 5: (-0.70711 - 0.70711i), 6: (0.00000 - 1.00000i), 7: ( 0.70711 - 0.70711i)
          
          -- Wegen der Faktoren (+/-0.70711 +/-0.70711i) haben die geraden Zeilen (beginnend bei 1) 12 statt 8 Subtraktionen
          -- Zunaechst werden die Werte aufsummiert, die mit dem Faktor 1 "multipliziert" werden muessen.
          -- Dann werden die Werte aufsummiert, die mit 0,70711 multipliziert werden muessen. Um sowohl den Quelltext und 
          -- insbesondere auch den Platzbedarf auf dem Chip klein zuhalten, wird die Multiplikation auf die Summe aller und 
          -- nicht auf die einzelnen Werte angewandt.
          -- Da immer genau die Haelfte der Faktoren positiv und die andere negativ ist, werden die Eingangswerte so sortiert,
          -- dass keine Negationen noetig sind.
          when 1 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_real(4)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(2)(I_col), bit_width_adder) - resize(matrix_imag(6)(I_col), bit_width_adder); 
              -- MultPart
              temp_re(2) := resize(matrix_real(1)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_imag(1)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);
              temp_re(4) := resize(matrix_imag(3)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              temp_re(5) := resize(matrix_real(7)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_real(2)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(6)(I_col), bit_width_adder) - resize(matrix_imag(4)(I_col), bit_width_adder);
              -- MultPart
              temp_im(2) := resize(matrix_imag(1)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_real(5)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_im(4) := resize(matrix_real(7)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_im(5) := resize(matrix_imag(7)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
           
          -- 3. Zeile aus W
          -- 0: (1.00000 + 0.00000i), 1: (0.00000 + 1.00000i), 2: (-1.00000 + 0.00000i), 3: (-0.00000 - 1.00000i),
          -- 4: (1.00000 - 0.00000i), 5: (0.00000 + 1.00000i), 6: (-1.00000 + 0.00000i), 7: (-0.00000 - 1.00000i)
          when 2 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_real(2)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(1)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_re(2) := resize(matrix_real(4)(I_col), bit_width_adder) - resize(matrix_real(6)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_imag(5)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);
              --Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(3)(I_col), bit_width_adder) - resize(matrix_imag(2)(I_col), bit_width_adder);
              temp_im(2) := resize(matrix_imag(4)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_real(7)(I_col), bit_width_adder) - resize(matrix_imag(6)(I_col), bit_width_adder);
            
          -- 4. Zeile aus W
          -- 0: ( 1.00000 + 0.00000i), 1: (-0.70711 + 0.70711i), 2: (-0.00000 - 1.00000i), 3: ( 0.70711 + 0.70711i)
          -- 4: (-1.00000 + 0.00000i), 5: ( 0.70711 - 0.70711i), 6: ( 0.00000 + 1.00000i), 7: (-0.70711 - 0.70711i)
          when 3 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_imag(2)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(6)(I_col), bit_width_adder) - resize(matrix_real(4)(I_col), bit_width_adder);
              --MultPart
              temp_re(2) := resize(matrix_imag(1)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_real(3)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
              temp_re(4) := resize(matrix_imag(3)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);
              temp_re(5) := resize(matrix_real(5)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);
              
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_imag(4)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(2)(I_col), bit_width_adder) - resize(matrix_real(6)(I_col), bit_width_adder);
              --MultPart
              temp_im(2) := resize(matrix_imag(3)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_real(5)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_im(4) := resize(matrix_imag(5)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_im(5) := resize(matrix_real(7)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);

          -- 5. Zeile  
          -- 0: (1.00000 + 0.00000i), 1: (-1.00000 + 0.00000i), 2: (1.00000 - 0.00000i), 3: (-1.00000 + 0.00000i),
          -- 4: (1.00000 - 0.00000i), 5: (-1.00000 + 0.00000i), 6: (1.00000 - 0.00000i), 7: (-1.00000 + 0.00000i)
          when 4 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_real(2)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_re(2) := resize(matrix_real(4)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_real(6)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_imag(2)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_im(2) := resize(matrix_imag(4)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_imag(6)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);

          -- 6. Zeile  
          -- 0: ( 1.00000 + 0.00000i), 1: (-0.70711 - 0.70711i), 2: ( 0.00000 + 1.00000i), 3: ( 0.70711 - 0.70711i), 
          -- 4: (-1.00000 + 0.00000i)  5: ( 0.70711 + 0.70711i), 6: (-0.00000 - 1.00000i), 7: (-0.70711 + 0.70711i)
          when 5 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_real(4)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(2)(I_col), bit_width_adder) - resize(matrix_imag(6)(I_col), bit_width_adder);
              --MultPart
              temp_re(2) := resize(matrix_real(3)(I_col), bit_width_adder) - resize(matrix_real(1)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_real(5)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_re(4) := resize(matrix_imag(5)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_re(5) := resize(matrix_imag(7)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_real(2)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(6)(I_col), bit_width_adder) - resize(matrix_imag(4)(I_col), bit_width_adder);
              --MultPart
              temp_im(2) := resize(matrix_real(1)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_real(3)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              temp_im(4) := resize(matrix_imag(3)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);
              temp_im(5) := resize(matrix_imag(5)(I_col), bit_width_adder) - resize(matrix_imag(7)(I_col), bit_width_adder);

          -- 7. Zeile
          -- 0: (1.00000 + 0.00000i), 1: (-0.00000 - 1.00000i), 2: (-1.00000 + 0.00000i), 3: ( 0.00000 + 1.00000i),
          -- 4: (1.00000 - 0.00000i), 5: (-0.00000 - 1.00000i), 6: (-1.00000 + 0.00000i), 7: (-0.00000 + 1.00000i)
          when 6 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(3)(I_col), bit_width_adder) - resize(matrix_real(2)(I_col), bit_width_adder);
              temp_re(2) := resize(matrix_real(4)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_imag(7)(I_col), bit_width_adder) - resize(matrix_real(6)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_imag(2)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(1)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_im(2) := resize(matrix_imag(4)(I_col), bit_width_adder) - resize(matrix_imag(6)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_real(5)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);

          -- 8. Zeile  
          -- 0: ( 1.00000 + 0.00000i), 1: ( 0.70711 - 0.70711i), 2: (-0.00000 - 1.00000i), 3: (-0.70711 - 0.70711i),
          -- 4: (-1.00000 + 0.00000i), 5: (-0.70711 + 0.70711i), 6: (-0.00000 + 1.00000i), 7: ( 0.70711 + 0.70711i)
          when 7 =>
              -- Real
              temp_re(0) := resize(matrix_real(0)(I_col), bit_width_adder) - resize(matrix_imag(2)(I_col), bit_width_adder);
              temp_re(1) := resize(matrix_imag(6)(I_col), bit_width_adder) - resize(matrix_real(4)(I_col), bit_width_adder);
              --MultPart
              temp_re(2) := resize(matrix_real(1)(I_col), bit_width_adder) - resize(matrix_imag(1)(I_col), bit_width_adder);
              temp_re(3) := resize(matrix_imag(5)(I_col), bit_width_adder) - resize(matrix_real(3)(I_col), bit_width_adder);
              temp_re(4) := resize(matrix_real(7)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_re(5) := resize(matrix_imag(7)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              -- Imag
              temp_im(0) := resize(matrix_imag(0)(I_col), bit_width_adder) - resize(matrix_imag(4)(I_col), bit_width_adder);
              temp_im(1) := resize(matrix_real(2)(I_col), bit_width_adder) - resize(matrix_real(6)(I_col), bit_width_adder);
              --MultPart
              temp_im(2) := resize(matrix_real(1)(I_col), bit_width_adder) - resize(matrix_imag(3)(I_col), bit_width_adder);
              temp_im(3) := resize(matrix_imag(1)(I_col), bit_width_adder) - resize(matrix_real(5)(I_col), bit_width_adder);
              temp_im(4) := resize(matrix_real(3)(I_col), bit_width_adder) - resize(matrix_imag(5)(I_col), bit_width_adder);
              temp_im(5) := resize(matrix_imag(7)(I_col), bit_width_adder) - resize(matrix_real(7)(I_col), bit_width_adder);

          when others => element := element; -- "dummy arbeit", es sind bereits alle Faelle abgedeckt!
        end case;  
        
        next_dft_state <= additions_stage1;  
        
    
      when additions_stage1 =>  -- dft_state_out = 2
      
        -- Es wird vor jeder Addition ein Bitshift auf die Summanden angewandt, um den Wertebereich der Speichervariable beim zurueckschreiben nicht zu ueberschreiten (1. Mal)
          
        -- Zeilen 1, 3, 5, 7 (ungerade) aufsummieren (bzw. 0(000XXX), 2(010XXX), 4(100XXX), 6(110XXX) beginnend bei 0)
        if element(3) = '0' then
                   
          
          
          -- Real  
          temp_re(0) := resize(temp_re(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(1)(bit_width_adder-1 downto 1), bit_width_adder);            
          temp_re(1) := resize(temp_re(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(3)(bit_width_adder-1 downto 1), bit_width_adder);
          -- Imag
          temp_im(0) := resize(temp_im(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(1)(bit_width_adder-1 downto 1), bit_width_adder);
          temp_im(1) := resize(temp_im(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(3)(bit_width_adder-1 downto 1), bit_width_adder);
        else
          -- gerade Zeilen aus W
          -- Real
          --ConstPart
          temp_re(0) := resize(temp_re(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(1)(bit_width_adder-1 downto 1), bit_width_adder);
          --MultPart
          temp_re(2) := resize(temp_re(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(3)(bit_width_adder-1 downto 1), bit_width_adder);
          temp_re(4) := resize(temp_re(4)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(5)(bit_width_adder-1 downto 1), bit_width_adder);
          -- Imag
          --ConstPart
          temp_im(0) := resize(temp_im(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(1)(bit_width_adder-1 downto 1), bit_width_adder);
          --MultPart
          temp_im(2) := resize(temp_im(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(3)(bit_width_adder-1 downto 1), bit_width_adder);
          temp_im(4) := resize(temp_im(4)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(5)(bit_width_adder-1 downto 1), bit_width_adder);
        end if;

        next_dft_state <= additions_stage2;
        
        
      when additions_stage2 =>  -- dft_state_out = 3
        -- Es wird vor jeder Addition ein Bitshift auf die Summanden angewandt, um den Wertebereich der Speichervariable nicht zu ueberschreiten (2. Mal)
        -- Zusaetzlich wird wird beim Zuweisen der ungeraden Zeilen an die 1D-DFT-Matrix zwei wweitere Male geshiftet.
        -- 1 Mal, um den Wertebereich der 1D- bzw. 2D-DFT-Matrix klein genug zu halten, ein weiteres Mal, um gleich oft wie bei den geraden Zeilen zu shiften
        
        -- Zeilen 1, 3, 5, 7 (wie oben)
        if element(3) = '0' then
        
            -- Real
            temp_re(0) := resize(temp_re(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(1)(bit_width_adder-1 downto 1), bit_width_adder);
            -- Imag
            temp_im(0) := resize(temp_im(0)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(1)(bit_width_adder-1 downto 1), bit_width_adder);
        
            -- Hier werden die Bits um 2 Stellen nach rechts geschoben, damit die Werte mit den Zeilen 2, 4, 6, 8 vergleichbar sind. Dort wird insgesamt gleich 
            -- oft geshiftet, aber auch 1x mehr aufaddiert.
            -- Indizes vertauschen -> Transponiert abspeichern
            if dft_1d_2d = '0' then
                dft_1d_real(I_col)(row_col_idx) := resize(temp_re(0)(bit_width_adder-1 downto 2), bit_width_extern);
                dft_1d_imag(I_col)(row_col_idx) := resize(temp_im(0)(bit_width_adder-1 downto 2), bit_width_extern);
            else
                result_real(I_col)(row_col_idx) <= resize(temp_re(0)(bit_width_adder-1 downto 2), bit_width_extern);
                result_imag(I_col)(row_col_idx) <= resize(temp_im(0)(bit_width_adder-1 downto 2), bit_width_extern);
            end if;
            
            element := element+1;
            element_out <= element;
            
            -- naechster Zustand
            next_dft_state <= twiddle_calc;
            
        else
            -- Real
            temp_re(2) := resize(temp_re(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_re(4)(bit_width_adder-1 downto 1), bit_width_adder);

            -- Imag
            temp_im(2) := resize(temp_im(2)(bit_width_adder-1 downto 1), bit_width_adder) + resize(temp_im(4)(bit_width_adder-1 downto 1), bit_width_adder);
            
            -- naechster Zustand
            next_dft_state <= const_mult;
        end if;
          
            
      when const_mult =>  -- dft_state_out = 4
      
        -- Der Zielvektor der Multiplikation ist 26 Bit breit, die beiden Multiplikanten sind mit je 13 Bit wie gefordert halb so breit.
        
        -- Zeilen 2, 4, 6, 8 (vergleichbar mit oben)
        mult_re := temp_re(2) * twiddle_coeff; --(16 downto 16-(bit_width_adder-1));
        mult_im := temp_im(2) * twiddle_coeff; --(16 downto 16-(bit_width_adder-1));
        
        next_dft_state <= additions_stage3;

        
      when additions_stage3 =>  -- dft_state_out = 5
          
        -- Die vordersten 12 Bit des Multiplikationsergebnisses werden verwendet und um 1 Bit nach rechts geshiftet, damit der Wert halbiert wird und der Zielvektor spaeter keinen Ueberlauf hat.
        -- Um wieder die vollen 13 Bit zu erhalten, wird die resize-Funktion verwendet.
        -- Real
                
        temp14bit_re := resize(mult_re(bit_width_multiplier-4 downto bit_width_multiplier-4-bit_width_extern), bit_width_adder+1) + resize(temp_re(0)(bit_width_adder-1 downto 1), bit_width_adder+1);
        temp_re(0) := temp14bit_re(bit_width_adder downto 1);
          
        -- Imag
        temp14bit_im := resize(mult_im(bit_width_multiplier-4 downto bit_width_multiplier-4-bit_width_extern), bit_width_adder+1) + resize(temp_im(0)(bit_width_adder-1 downto 1), bit_width_adder+1);
        temp_im(0) := temp14bit_im(bit_width_adder downto 1);
            
        -- Indizes vertauschen -> Transponiert abspeichern
        if dft_1d_2d = '0' then
          dft_1d_real(I_col)(row_col_idx) := temp_re(0)(bit_width_adder-1 downto 1);
          dft_1d_imag(I_col)(row_col_idx) := temp_im(0)(bit_width_adder-1 downto 1);
        else
          result_real(I_col)(row_col_idx) <= temp_re(0)(bit_width_adder-1 downto 1);
          result_imag(I_col)(row_col_idx) <= temp_im(0)(bit_width_adder-1 downto 1);
        end if;
        
        next_dft_state <= twiddle_calc;    
        if element = 63 then
          if dft_1d_2d = '1' then
            next_dft_state <= set_ready_bit;            
          end if;
          dft_1d_2d := not dft_1d_2d;
          dft_1d_2d_out <= dft_1d_2d;
        end if;
        
        
        element := element+1;
        element_out <= element;
        
        
      when set_ready_bit => 
        result_ready <= '1';
        next_dft_state <= twiddle_calc;

            
      when others => next_dft_state <= twiddle_calc;
    end case;
        
  end process;
end arch;
 
