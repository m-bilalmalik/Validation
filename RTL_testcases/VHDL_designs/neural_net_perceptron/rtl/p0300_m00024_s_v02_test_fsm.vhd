-- COPYRIGHT (C) 2022 by Jens Gutschmidt / VIVARE GmbH Switzerland
-- (email: opencores@vivare-services.com)
-- 
-- This program is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or any
-- later version.
-- 
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-- 
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
--USE ieee.numeric_std.all;
LIBRARY work;
USE work.memory_vhd_v03_pkg.ALL;

ENTITY p0300_m00024_s_v02_test_fsm IS
   PORT( 
      clk_i        : IN     std_logic;
      cnti_end_i   : IN     std_logic;
      cntj_end_i   : IN     std_logic;
      ctrl_rdlat_i : IN     MEM_LAT_CNT_WIDTH_T;
      ctrl_rdy7_i  : IN     std_logic;
      ctrl_start_i : IN     std_logic;
      ctrl_wrlat_i : IN     MEM_LAT_CNT_WIDTH_T;
      ds_i         : IN     DATA_T;
      dt_i         : IN     DATA_T;
      dw_i         : IN     DATA_T;
      offset_i     : IN     DATA_T;
      rst_n_i      : IN     std_logic;
      cnteni_o     : OUT    std_logic;
      cntenj_o     : OUT    std_logic;
      ctrl_int_o   : OUT    std_logic;
      ctrl_rdy_o   : OUT    std_logic;
      dout_o       : OUT    DATA_T;
      we_s_o       : OUT    std_logic;
      we_t_o       : OUT    std_logic;
      we_w_o       : OUT    std_logic
   );

-- Declarations

END p0300_m00024_s_v02_test_fsm ;
-- COPYRIGHT (C) 2022 Jens Gutschmidt /
-- VIVARE GmbH Switzerland
-- (email: opencores@vivare-services.com)
-- 
-- Versions:
-- Revision 2.0  2022/07/02
-- - Introduced latency for write
-- Revision 1.0  2022/06/17
-- -- First draft
-- 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
--USE ieee.numeric_std.all;
LIBRARY work;
USE work.memory_vhd_v03_pkg.ALL;
 
ARCHITECTURE fsm OF p0300_m00024_s_v02_test_fsm IS

   -- Architecture Declarations
   SIGNAL ctrl_int_reg : std_logic;  
   SIGNAL ctrl_rdlat_reg : MEM_LAT_CNT_WIDTH_T;  
   SIGNAL ctrl_start_reg : std_logic;  
   SIGNAL ctrl_wrlat_reg : MEM_LAT_CNT_WIDTH_T;  
   SIGNAL dt_reg : DATA_T;  
   SIGNAL dw_reg : DATA_T;  

   TYPE STATE_TYPE IS (
      S02,
      S05,
      S04,
      S07,
      S06,
      S11,
      S12,
      S13,
      S14,
      S15,
      S01,
      S00,
      S09,
      S08,
      S10,
      S03
   );
 
   -- Declare current and next state signals
   SIGNAL current_state : STATE_TYPE;
   SIGNAL next_state : STATE_TYPE;

BEGIN

   -----------------------------------------------------------------
   clocked_proc : PROCESS ( 
      clk_i
   )
   -----------------------------------------------------------------
   BEGIN
      IF (clk_i'EVENT AND clk_i = '1') THEN
         IF (rst_n_i = '0') THEN
            current_state <= S00;
            -- Default Reset Values
            ctrl_int_reg <= '0';
            ctrl_rdlat_reg <= (others => '0');
            ctrl_start_reg <= '0';
            ctrl_wrlat_reg <= (others => '0');
            dt_reg <= (others => '0');
            dw_reg <= (others => '0');
         ELSE
            current_state <= next_state;
            -- Default Assignment To Internals
            ctrl_int_reg <= '0';
            ctrl_rdlat_reg <= ctrl_rdlat_reg;
            ctrl_start_reg <= ctrl_start_i;
            ctrl_wrlat_reg <= ctrl_wrlat_reg;
            dt_reg <= dt_i;
            dw_reg <= dw_i;

            -- Combined Actions
            CASE current_state IS
               -- Clear T
               WHEN S02 => 
                  ctrl_wrlat_reg <= ctrl_wrlat_i;
               -- Replace
               -- multiplication
               WHEN S04 => 
                  ctrl_wrlat_reg <= ctrl_wrlat_i;
               -- Dummy cycles to
               -- equalize latency.
               -- j-path
               WHEN S13 => 
                  ctrl_rdlat_reg <= '0' & ctrl_rdlat_reg ( MEM_LAT_CNT_WIDTH - 1 downto 1 );
               -- Set interrupt
               -- flag
               WHEN S14 => 
                  ctrl_int_reg <= '1';
               -- Dummy cycles to
               -- equalize latency.
               -- End-path
               WHEN S15 => 
                  ctrl_rdlat_reg <= '0' & ctrl_rdlat_reg ( MEM_LAT_CNT_WIDTH - 1 downto 1 );
               -- Next i
               WHEN S09 => 
                  ctrl_rdlat_reg <= ctrl_rdlat_i;
               -- Dummy cycles to
               -- equalize latency.
               -- Write-path (i)
               WHEN S08 => 
                  ctrl_wrlat_reg <= '0' & ctrl_wrlat_reg ( MEM_LAT_CNT_WIDTH - 1 downto 1 );
               -- Dummy cycles to
               -- equalize latency.
               -- i-path
               WHEN S10 => 
                  ctrl_rdlat_reg <= '0' & ctrl_rdlat_reg ( MEM_LAT_CNT_WIDTH - 1 downto 1 );
               -- Dummy cycles to
               -- equalize latency.
               -- Write-path (i)
               WHEN S03 => 
                  ctrl_wrlat_reg <= '0' & ctrl_wrlat_reg ( MEM_LAT_CNT_WIDTH - 1 downto 1 );
               WHEN OTHERS =>
                  NULL;
            END CASE;
         END IF;
      END IF;
   END PROCESS clocked_proc;
 
   -----------------------------------------------------------------
   nextstate_proc : PROCESS ( 
      cnti_end_i,
      cntj_end_i,
      ctrl_rdlat_reg,
      ctrl_rdy7_i,
      ctrl_start_reg,
      ctrl_wrlat_reg,
      current_state,
      ds_i
   )
   -----------------------------------------------------------------
   BEGIN
      CASE current_state IS
         -- Clear T
         WHEN S02 => 
            next_state <= S03;
         -- ADD if
         -- DS > 0
         WHEN S05 => 
            next_state <= S08;
         -- Replace
         -- multiplication
         WHEN S04 => 
            IF (signed (ds_i) > 0) THEN 
               next_state <= S05;
            ELSIF (signed (ds_i) < 0) THEN 
               next_state <= S07;
            ELSE
               next_state <= S06;
            END IF;
         -- SUB if
         -- DS < 0
         WHEN S07 => 
            next_state <= S08;
         -- Do nothing if
         -- DS = 0
         WHEN S06 => 
            next_state <= S08;
         -- Add offset to T
         WHEN S11 => 
            next_state <= S12;
         -- Next j
         WHEN S12 => 
            IF (cntj_end_i = '1') THEN 
               next_state <= S14;
            ELSE
               next_state <= S13;
            END IF;
         -- Dummy cycles to
         -- equalize latency.
         -- j-path
         WHEN S13 => 
            IF (unsigned ( ctrl_rdlat_reg ) <= 3) THEN 
               next_state <= S02;
            ELSE
               next_state <= S13;
            END IF;
         -- Set interrupt
         -- flag
         WHEN S14 => 
            next_state <= S15;
         -- Dummy cycles to
         -- equalize latency.
         -- End-path
         WHEN S15 => 
            IF (unsigned ( ctrl_rdlat_reg ) <= 7) THEN 
               next_state <= S01;
            ELSE
               next_state <= S15;
            END IF;
         -- Wait for next
         -- TEST request
         WHEN S01 => 
            IF (ctrl_start_reg = '1') THEN 
               next_state <= S02;
            ELSE
               next_state <= S01;
            END IF;
         -- Reset state
         WHEN S00 => 
            IF (ctrl_rdy7_i = '1') THEN 
               next_state <= S01;
            ELSE
               next_state <= S00;
            END IF;
         -- Next i
         WHEN S09 => 
            IF (cnti_end_i = '1') THEN 
               next_state <= S11;
            ELSE
               next_state <= S10;
            END IF;
         -- Dummy cycles to
         -- equalize latency.
         -- Write-path (i)
         WHEN S08 => 
            IF (unsigned ( ctrl_wrlat_reg ) <= 3) THEN 
               next_state <= S09;
            ELSE
               next_state <= S08;
            END IF;
         -- Dummy cycles to
         -- equalize latency.
         -- i-path
         WHEN S10 => 
            IF (unsigned ( ctrl_rdlat_reg ) <= 3) THEN 
               next_state <= S04;
            ELSE
               next_state <= S10;
            END IF;
         -- Dummy cycles to
         -- equalize latency.
         -- Write-path (i)
         WHEN S03 => 
            IF (unsigned ( ctrl_wrlat_reg ) <= 1) THEN 
               next_state <= S04;
            ELSE
               next_state <= S03;
            END IF;
         WHEN OTHERS =>
            next_state <= S00;
      END CASE;
   END PROCESS nextstate_proc;
 
   -----------------------------------------------------------------
   output_proc : PROCESS ( 
      ctrl_int_reg,
      current_state,
      dt_reg,
      dw_reg,
      offset_i
   )
   -----------------------------------------------------------------
   BEGIN
      -- Default Assignment
      cnteni_o <= '0';
      cntenj_o <= '0';
      ctrl_int_o <= ctrl_int_reg;
      ctrl_rdy_o <= '0';
      dout_o <= (others => '0');
      we_s_o <= '0';
      we_t_o <= '0';
      we_w_o <= '0';

      -- Combined Actions
      CASE current_state IS
         -- Clear T
         WHEN S02 => 
            dout_o <= (others => '0');
            we_t_o <= '1';
         -- ADD if
         -- DS > 0
         WHEN S05 => 
            --dout_o <= signed (dt_i) + signed (dw_i);
            dout_o <= signed (dt_reg) + signed (dw_reg);
            we_t_o <= '1';
         -- SUB if
         -- DS < 0
         WHEN S07 => 
            --dout_o <= signed (dt_i) - signed (dw_i);
            dout_o <= signed (dt_reg) - signed (dw_reg);
            we_t_o <= '1';
         -- Add offset to T
         WHEN S11 => 
            --dout_o <= signed (dt_i) + signed (offset_i);
            dout_o <= signed (dt_reg) + signed (offset_i);
            we_t_o <= '1';
         -- Next j
         WHEN S12 => 
            cntenj_o <= '1';
         -- Wait for next
         -- TEST request
         WHEN S01 => 
            ctrl_rdy_o <= '1';
         -- Next i
         WHEN S09 => 
            cnteni_o <= '1';
         WHEN OTHERS =>
            NULL;
      END CASE;
   END PROCESS output_proc;
 
END fsm;
