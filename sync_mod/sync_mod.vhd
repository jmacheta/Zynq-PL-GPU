library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sync_mod is
    Port (     CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               Y_POS : out STD_LOGIC_VECTOR (9 downto 0);
               X_POS : out STD_LOGIC_VECTOR (9 downto 0);
               H_SYNC : out STD_LOGIC;
               V_SYNC : out STD_LOGIC;
               -- Prescaler 100->25MHz output
               EN25 : out STD_LOGIC;
               BLANK : out STD_LOGIC 
         );
end sync_mod;

architecture behavioral of sync_mod is
    -- Video Parameters
    constant HR : integer := 640;   -- Horizontal Resolution
    constant HFP : integer := 16;   -- Horizontal Front Porch 
    constant HBP : integer := 48;   -- Horizontal Back Porch
    constant HRet : integer := 96;  -- Horizontal retrace
    
    constant VR : integer := 480;   -- Vertical Resolution
    constant VFP : integer := 10;   -- Vertical Front Porch 
    constant VBP : integer := 33;   -- Vertical Back Porch
    constant VRet : integer := 2;   -- Vertical Retrace
   
    -- Sync counter
    signal counter_h : integer range 0 to HR + HFP + HBP + HRet - 1;
    signal counter_v : integer range 0 to VR + VFP + VBP + VRet - 1;
      
    -- State signals
    signal h_end, v_end : std_logic:='0';
    
    -- Output Signals(buffer)
    signal h_sync_buf : std_logic := '0';
    signal v_sync_buf : std_logic := '0';
    
    -- Pixel counter
    signal sx_pos : integer range 0 to HR;
    signal sy_pos : integer range 0 to VR;
    -- Video_on_off
    signal sblank : std_logic;
    
    signal DIVIDER: std_logic_vector(1 downto 0) := "00";	-- internal divider register 
    constant divide_factor: integer := 4;			-- divide factor user constant
    signal EN : std_logic;
    
begin
    
    process (CLK, RESET)
	begin
		if RESET = '1' then
			DIVIDER <= (others => '0');
		elsif CLK'event and CLK = '1' then
			if DIVIDER = (divide_factor-1) then
				DIVIDER <= (others => '0');
			else
				DIVIDER <= DIVIDER + 1;
			end if;
		end if;
	end process;

    EN <= '1' when DIVIDER = (divide_factor-1) else '0';
    EN25 <= EN;
    
     -- Video on/off
    sblank <= '0' when (counter_v >= VBP) and (counter_v < VBP + VR) and (counter_h >= HBP) and (counter_h < HBP + HR) 
        else '1';

    -- End of Horizontal scanning 
    h_end <= '1' when counter_h = HR + HFP + HBP + HRet - 1
        else '0'; 
                
    -- End of Vertical scanning
    v_end <= '1' when counter_v = VR + VFP + VBP + VRet - 1
        else '0'; 
                
     -- Horizontal Counter
     process(CLK, RESET)
        begin
            if RESET = '1' then
                counter_h <= 0;
            else
                if CLK'event and CLK = '1' then
                    if EN = '1' then
                        if h_end='1' then
                            counter_h <= 0;
                        else
                            counter_h <= counter_h + 1;
                        end if;
                    end if;
                end if;
            end if;
     end process;

    -- Vertical Counter
    process(CLK, RESET)
    begin 
        if RESET = '1' then
            counter_v <= 0;
        else
            if CLK'event and CLK = '1' then
                if EN = '1' then
                    if h_end = '1' then
                        if v_end = '1' then
                            counter_v <= 0;
                        else
                            counter_v <= counter_v + 1;
                        end if;
                    end if;
                end if;
           end if;
        end if;
    end process;

   -- Pixel x counter
    process(CLK , RESET)
    begin 
        if RESET = '1' then 
            sx_pos <= 0;
        else 
            if CLK'event and CLK = '1' then
                if sblank = '0' then
                    if EN = '1' then 
                        if sx_pos = HR - 1 then
                            sx_pos <= 0;
                        else
                            sx_pos <= sx_pos + 1;
                        end if;
                    end if;
                -- else
                    -- sx_pos <= 0;
                end if;
            end if;
        end if;
    end process;

--   -- Pixel y counter
    process(CLK, RESET)
    begin 
        if RESET = '1' then
            sy_pos <= 0;
        else 
            if CLK'event and CLK = '1' then
                if EN = '1' then
                    if h_end = '1' then 
                        if counter_v > VBP -1 and counter_v < VR + VBP - 1 then
                            sy_pos <= sy_pos + 1;
                        else 
                            sy_pos <= 0;
                        end if; 
                    end if;
                end if;
            end if;
        end if;
    end process;

   -- Buffer
    h_sync_buf <= '1' when counter_h < HBP + HR + HFP
        else '0';
                           
     v_sync_buf <= '1' when counter_v < VBP + VR + VFP 
        else '0';

    --outputs
    Y_POS <= conv_std_logic_vector(sy_pos, 10); 
    X_POS <= conv_std_logic_vector(sx_pos, 10); 
    H_SYNC <= h_sync_buf;
    V_SYNC <= v_sync_buf;
    BLANK <= sblank;

end behavioral;