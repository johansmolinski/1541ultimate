-------------------------------------------------------------------------------
-- Title      : u2p_nios
-- Author     : Gideon Zweijtzer <gideon.zweijtzer@gmail.com>
-------------------------------------------------------------------------------
-- Description: Toplevel based on the "solo" nios; without Altera DDR2 ctrl.
-------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use work.io_bus_pkg.all;
    use work.mem_bus_pkg.all;
    use work.my_math_pkg.all;
        
entity u2p_cia_lockstep is
port (
    dummy            : out   std_logic;
    
    -- slot side
    SLOT_PHI2        : in    std_logic;
    SLOT_DOTCLK      : in    std_logic;
    SLOT_RSTn        : inout std_logic;
    SLOT_BUFFER_ENn  : out   std_logic;
    SLOT_ADDR        : inout std_logic_vector(15 downto 0);
    SLOT_DATA        : inout std_logic_vector(7 downto 0);
    SLOT_RWn         : inout std_logic;
    SLOT_BA          : in    std_logic;
    SLOT_DMAn        : out   std_logic;
    SLOT_EXROMn      : inout std_logic;
    SLOT_GAMEn       : inout std_logic;
    SLOT_ROMHn       : in    std_logic;
    SLOT_ROMLn       : in    std_logic;
    SLOT_IO1n        : in    std_logic;
    SLOT_IO2n        : in    std_logic;
    SLOT_IRQn        : inout std_logic;
    SLOT_NMIn        : inout std_logic;
    SLOT_VCC         : in    std_logic;
    
    -- memory
    SDRAM_A     : out   std_logic_vector(13 downto 0); -- DRAM A
    SDRAM_BA    : out   std_logic_vector(2 downto 0) := (others => '0');
    SDRAM_DQ    : inout std_logic_vector(7 downto 0);
    SDRAM_DM    : inout std_logic;
    SDRAM_CSn   : out   std_logic;
    SDRAM_RASn  : out   std_logic;
    SDRAM_CASn  : out   std_logic;
    SDRAM_WEn   : out   std_logic;
    SDRAM_CKE   : out   std_logic;
    SDRAM_CLK   : inout std_logic;
    SDRAM_CLKn  : inout std_logic;
    SDRAM_ODT   : out   std_logic;
    SDRAM_DQS   : inout std_logic;
     
    AUDIO_MCLK  : out   std_logic := '0';
    AUDIO_BCLK  : out   std_logic := '0';
    AUDIO_LRCLK : out   std_logic := '0';
    AUDIO_SDO   : out   std_logic := '0';
    AUDIO_SDI   : in    std_logic;

    -- IEC bus
    IEC_ATN     : inout std_logic;
    IEC_DATA    : inout std_logic;
    IEC_CLOCK   : inout std_logic;
    IEC_RESET   : in    std_logic;
    IEC_SRQ_IN  : inout std_logic;
    
    LED_DISKn   : out   std_logic; -- activity LED
    LED_CARTn   : out   std_logic;
    LED_SDACTn  : out   std_logic;
    LED_MOTORn  : out   std_logic;
    
    -- Ethernet RMII
    ETH_RESETn      : out std_logic := '1';
    ETH_IRQn        : in  std_logic;
    
    RMII_REFCLK     : in  std_logic;
    RMII_CRS_DV     : in  std_logic;
    RMII_RX_ER      : in  std_logic;
    RMII_RX_DATA    : in  std_logic_vector(1 downto 0);
    RMII_TX_DATA    : out std_logic_vector(1 downto 0);
    RMII_TX_EN      : out std_logic;

    MDIO_CLK    : out   std_logic := '0';
    MDIO_DATA   : inout std_logic := 'Z';

    -- Speaker data
    SPEAKER_DATA    : out std_logic := '0';
    SPEAKER_ENABLE  : out std_logic := '0';

    -- Debug UART
    UART_TXD    : out   std_logic;
    UART_RXD    : in    std_logic;
    
    -- I2C Interface for RTC, audio codec and usb hub
    I2C_SDA     : inout std_logic := 'Z';
    I2C_SCL     : inout std_logic := 'Z';
    I2C_SDA_18  : inout std_logic := 'Z';
    I2C_SCL_18  : inout std_logic := 'Z';

    -- Flash Interface
    FLASH_CSn   : out   std_logic;
    FLASH_SCK   : out   std_logic;
    FLASH_MOSI  : out   std_logic;
    FLASH_MISO  : in    std_logic;
    FLASH_SEL   : out   std_logic := '0';
    FLASH_SELCK : out   std_logic := '0';

    -- USB Interface (ULPI)
    ULPI_RESET  : out   std_logic;
    ULPI_CLOCK  : in    std_logic;
    ULPI_NXT    : in    std_logic;
    ULPI_STP    : out   std_logic;
    ULPI_DIR    : in    std_logic;
    ULPI_DATA   : inout std_logic_vector(7 downto 0);

    HUB_RESETn  : out   std_logic := '1';
    HUB_CLOCK   : out   std_logic := '0';

	-- Misc
	BOARD_REVn  : in    std_logic_vector(4 downto 0);

    -- Cassette Interface
    CAS_MOTOR   : in    std_logic := '0';
    CAS_SENSE   : inout std_logic := 'Z';
    CAS_READ    : inout std_logic := 'Z';
    CAS_WRITE   : inout std_logic := 'Z';
    
    -- Buttons
    BUTTON      : in    std_logic_vector(2 downto 0));

end entity;

architecture rtl of u2p_cia_lockstep is
    function or_reduce(a: std_logic_vector) return std_logic is
        variable o : std_logic;
    begin
        o := '0';
        for i in a'range loop
            o := o or a(i);
        end loop;
        return o;
    end function;

    component nios_solo is
        port (
            clk_clk            : in  std_logic                     := 'X';             -- clk
            io_ack             : in  std_logic                     := 'X';             -- ack
            io_rdata           : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- rdata
            io_read            : out std_logic;                                        -- read
            io_wdata           : out std_logic_vector(7 downto 0);                     -- wdata
            io_write           : out std_logic;                                        -- write
            io_address         : out std_logic_vector(19 downto 0);                    -- address
            io_irq             : in  std_logic                     := 'X';             -- irq
            io_u2p_ack         : in  std_logic                     := 'X';             -- ack
            io_u2p_rdata       : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- rdata
            io_u2p_read        : out std_logic;                                        -- read
            io_u2p_wdata       : out std_logic_vector(7 downto 0);                     -- wdata
            io_u2p_write       : out std_logic;                                        -- write
            io_u2p_address     : out std_logic_vector(19 downto 0);                    -- address
            io_u2p_irq         : in  std_logic                     := 'X';             -- irq
            mem_mem_req_address     : out std_logic_vector(25 downto 0);                    -- mem_req_address
            mem_mem_req_byte_en     : out std_logic_vector(3 downto 0);                     -- mem_req_byte_en
            mem_mem_req_read_writen : out std_logic;                                        -- mem_req_read_writen
            mem_mem_req_request     : out std_logic;                                        -- mem_req_request
            mem_mem_req_tag         : out std_logic_vector(7 downto 0);                     -- mem_req_tag
            mem_mem_req_wdata       : out std_logic_vector(31 downto 0);                    -- mem_req_wdata
            mem_mem_resp_dack_tag   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_resp_dack_tag
            mem_mem_resp_data       : in  std_logic_vector(31 downto 0) := (others => 'X'); -- mem_resp_data
            mem_mem_resp_rack_tag   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_resp_rack_tag
            reset_reset_n      : in  std_logic                     := 'X'              -- reset_n
        );
    end component nios_solo;

    component pll
        PORT
        (
            inclk0      : IN STD_LOGIC  := '0';
            c0          : OUT STD_LOGIC ;
            c1          : OUT STD_LOGIC ;
            locked      : OUT STD_LOGIC 
        );
    end component;

    signal por_n        : std_logic;
    signal ref_reset    : std_logic;
    signal por_count    : unsigned(15 downto 0) := (others => '0');
    signal led_n        : std_logic_vector(0 to 3);
    signal RSTn_out     : std_logic;
    signal irq_oc, nmi_oc, rst_oc, dma_oc, exrom_oc, game_oc    : std_logic;
    signal slot_addr_o  : std_logic_vector(15 downto 0);
    signal slot_addr_t  : std_logic;
    signal slot_data_o  : std_logic_vector(7 downto 0);
    signal slot_data_t  : std_logic;
    signal slot_rwn_o   : std_logic;
    
    signal sys_clock    : std_logic;
    signal sys_reset    : std_logic;
    signal audio_clock  : std_logic;
    signal audio_reset  : std_logic;
    signal eth_reset    : std_logic;
    signal ulpi_reset_req : std_logic;
    signal button_i     : std_logic_vector(2 downto 0);
    signal buffer_en    : std_logic;
        
    -- miscellaneous interconnect
    signal ulpi_reset_i     : std_logic;
    
    -- memory controller interconnect
    signal memctrl_inhibit  : std_logic;
    signal is_idle          : std_logic;
    signal cpu_mem_req      : t_mem_req_32;
    signal cpu_mem_resp     : t_mem_resp_32;
    signal mem_req          : t_mem_req_32;
    signal mem_resp         : t_mem_resp_32;

    signal uart_txd_from_logic  : std_logic;
    signal i2c_sda_i   : std_logic;
    signal i2c_sda_o   : std_logic;
    signal i2c_scl_i   : std_logic;
    signal i2c_scl_o   : std_logic;
    signal mdio_o      : std_logic;
        
    -- IEC open drain
    signal iec_atn_o   : std_logic;
    signal iec_data_o  : std_logic;
    signal iec_clock_o : std_logic;
    signal iec_srq_o   : std_logic;
    signal sw_iec_o    : std_logic_vector(3 downto 0);
    signal sw_iec_i    : std_logic_vector(3 downto 0);
    
    -- io buses
    signal io_irq       : std_logic;
    signal io_req       : t_io_req;
    signal io_resp      : t_io_resp;
    signal io_u2p_req   : t_io_req;
    signal io_u2p_resp  : t_io_resp;
    signal io_req_new_io    : t_io_req;
    signal io_resp_new_io   : t_io_resp;
    signal io_req_remote    : t_io_req;
    signal io_resp_remote   : t_io_resp;
    signal io_req_ddr2      : t_io_req;
    signal io_resp_ddr2     : t_io_resp;

    -- audio
    signal audio_speaker    : signed(12 downto 0);
    signal audio_left       : signed(18 downto 0);
    signal audio_right      : signed(18 downto 0);
    signal speaker_vol      : std_logic_vector(3 downto 0);
begin
    process(RMII_REFCLK)
    begin
        if rising_edge(RMII_REFCLK) then
            if por_count = X"FFFF" then
                por_n <= '1';
            else
                por_n <= '0';
                por_count <= por_count + 1;
            end if;
        end if;
    end process;

    ref_reset <= not por_n;
    
    i_pll: pll port map (
        inclk0  => RMII_REFCLK, -- 50 MHz
        c0      => HUB_CLOCK, -- 24 MHz
        c1      => audio_clock, -- 12.245 MHz (47.831 kHz sample rate)
        locked  => open );

    i_audio_reset: entity work.level_synchronizer
    generic map ('1')
    port map (
        clock       => audio_clock,
        input       => sys_reset,
        input_c     => audio_reset  );
    
    i_ulpi_reset: entity work.level_synchronizer
    generic map ('1')
    port map (
        clock       => ulpi_clock,
        input       => ulpi_reset_req,
        input_c     => ulpi_reset_i  );

    i_eth_reset: entity work.level_synchronizer
    generic map ('1')
    port map (
        clock       => RMII_REFCLK,
        input       => sys_reset,
        input_c     => eth_reset  );

    i_nios: nios_solo
    port map (
        clk_clk            => sys_clock,
        reset_reset_n      => not sys_reset,

        io_ack             => io_resp.ack,
        io_rdata           => io_resp.data,
        io_read            => io_req.read,
        io_wdata           => io_req.data,
        io_write           => io_req.write,
        unsigned(io_address) => io_req.address,
        io_irq             => io_irq,

        io_u2p_ack         => io_u2p_resp.ack,
        io_u2p_rdata       => io_u2p_resp.data,
        io_u2p_read        => io_u2p_req.read,
        io_u2p_wdata       => io_u2p_req.data,
        io_u2p_write       => io_u2p_req.write,
        unsigned(io_u2p_address) => io_u2p_req.address,
        io_u2p_irq         => '0',
        
        unsigned(mem_mem_req_address) => cpu_mem_req.address,
        mem_mem_req_byte_en     => cpu_mem_req.byte_en,
        mem_mem_req_read_writen => cpu_mem_req.read_writen,
        mem_mem_req_request     => cpu_mem_req.request,
        mem_mem_req_tag         => cpu_mem_req.tag,
        mem_mem_req_wdata       => cpu_mem_req.data,
        mem_mem_resp_dack_tag   => cpu_mem_resp.dack_tag,
        mem_mem_resp_data       => cpu_mem_resp.data,
        mem_mem_resp_rack_tag   => cpu_mem_resp.rack_tag
    );

    i_split: entity work.io_bus_splitter
    generic map (
        g_range_lo => 8,
        g_range_hi => 9,
        g_ports    => 3
    )
    port map (
        clock      => sys_clock,
        req        => io_u2p_req,
        resp       => io_u2p_resp,
        reqs(0)    => io_req_new_io,
        reqs(1)    => io_req_ddr2,
        reqs(2)    => io_req_remote,
        resps(0)   => io_resp_new_io,
        resps(1)   => io_resp_ddr2,
        resps(2)   => io_resp_remote
    );

    i_memphy: entity work.ddr2_ctrl
    port map (
        ref_clock         => RMII_REFCLK,
        ref_reset         => ref_reset,
        sys_clock_o       => sys_clock,
        sys_reset_o       => sys_reset,
        clock             => sys_clock,
        reset             => sys_reset,
        io_req            => io_req_ddr2,
        io_resp           => io_resp_ddr2,
        inhibit           => memctrl_inhibit,
        is_idle           => is_idle,

        req               => mem_req,
        resp              => mem_resp,
        
        SDRAM_CLK         => SDRAM_CLK,
        SDRAM_CLKn        => SDRAM_CLKn,
        SDRAM_CKE         => SDRAM_CKE,
        SDRAM_ODT         => SDRAM_ODT,
        SDRAM_CSn         => SDRAM_CSn,
        SDRAM_RASn        => SDRAM_RASn,
        SDRAM_CASn        => SDRAM_CASn,
        SDRAM_WEn         => SDRAM_WEn,
        SDRAM_A           => SDRAM_A,
        SDRAM_BA          => SDRAM_BA(1 downto 0),
        SDRAM_DM          => SDRAM_DM,
        SDRAM_DQ          => SDRAM_DQ,
        SDRAM_DQS         => SDRAM_DQS
    );

    i_remote: entity work.update_io
    port map (
        clock       => sys_clock,
        reset       => sys_reset,
        slow_clock  => audio_clock,
        slow_reset  => audio_reset,
        io_req      => io_req_remote,
        io_resp     => io_resp_remote,
        flash_selck => FLASH_SELCK,
        flash_sel   => FLASH_SEL
    );

    i_u2p_io: entity work.u2p_io
    port map (
        clock      => sys_clock,
        reset      => sys_reset,
        io_req     => io_req_new_io,
        io_resp    => io_resp_new_io,
        mdc        => MDIO_CLK,
        mdio_i     => MDIO_DATA,
        mdio_o     => mdio_o,
        i2c_scl_i  => i2c_scl_i,
        i2c_scl_o  => i2c_scl_o,
        i2c_sda_i  => i2c_sda_i,
        i2c_sda_o  => i2c_sda_o,
        iec_i      => sw_iec_i,
        iec_o      => sw_iec_o,
        board_rev  => not BOARD_REVn,
        eth_irq_i  => ETH_IRQn,
        speaker_en => SPEAKER_ENABLE,
	    speaker_vol=> speaker_vol,
        hub_reset_n=> HUB_RESETn,
        ulpi_reset => ulpi_reset_req,
        buffer_en  => buffer_en
    );

    i2c_scl_i   <= I2C_SCL and I2C_SCL_18;
    i2c_sda_i   <= I2C_SDA and I2C_SDA_18;
    I2C_SCL     <= '0' when i2c_scl_o = '0' else 'Z';
    I2C_SDA     <= '0' when i2c_sda_o = '0' else 'Z';
    I2C_SCL_18  <= '0' when i2c_scl_o = '0' else 'Z';
    I2C_SDA_18  <= '0' when i2c_sda_o = '0' else 'Z';
    MDIO_DATA   <= '0' when mdio_o = '0' else 'Z';

    i_logic: entity work.ultimate_logic_32
    generic map (
        g_version       => X"0D",
        g_simulation    => false,
        g_ultimate2plus => true,
        g_clock_freq    => 62_500_000,
        g_baud_rate     => 115_200,
        g_timer_rate    => 200_000,
        g_microblaze    => false,
        g_big_endian    => false,
        g_icap          => false,
        g_uart          => true,
        g_drive_1541    => true,
        g_drive_1541_2  => false,
        g_hardware_gcr  => true,
        g_ram_expansion => true,
        g_extended_reu  => false,
        g_stereo_sid    => false,
        g_hardware_iec  => true,
        g_c2n_streamer  => false,
        g_c2n_recorder  => false,
        g_cartridge     => true,
        g_command_intf  => true,
        g_drive_sound   => true,
        g_rtc_chip      => false,
        g_rtc_timer     => false,
        g_usb_host      => false,
        g_usb_host2     => true,
        g_spi_flash     => true,
        g_vic_copper    => false,
        g_video_overlay => false,
        g_sampler       => false,
        g_analyzer      => true,
        g_profiler      => false,
        g_rmii          => true )
    port map (
        -- globals
        sys_clock   => sys_clock,
        sys_reset   => sys_reset,
    
        ulpi_clock  => ulpi_clock,
        ulpi_reset  => ulpi_reset_i,
    
        ext_io_req  => io_req,
        ext_io_resp => io_resp,
        ext_mem_req => cpu_mem_req,
        ext_mem_resp=> cpu_mem_resp,
        cpu_irq     => io_irq,
        
        -- slot side
        BUFFER_ENn  => open,
        VCC         => SLOT_VCC,

        phi2_i      => SLOT_PHI2,
        dotclk_i    => SLOT_DOTCLK,
        rstn_i      => SLOT_RSTn,
        rstn_o      => RSTn_out,
                                   
        slot_addr_o => slot_addr_o,
        slot_addr_i => SLOT_ADDR,
        slot_addr_t => slot_addr_t,
        slot_data_o => slot_data_o,
        slot_data_i => SLOT_DATA,
        slot_data_t => slot_data_t,
        rwn_i       => SLOT_RWn,
        rwn_o       => slot_rwn_o,
        exromn_i    => SLOT_EXROMn,
        exromn_o    => exrom_oc,
        gamen_i     => SLOT_GAMEn,
        gamen_o     => game_oc,
        irqn_i      => SLOT_IRQn,
        irqn_o      => irq_oc,
        nmin_i      => SLOT_NMIn,
        nmin_o      => nmi_oc,
        ba_i        => SLOT_BA,
        dman_o      => dma_oc,
        romhn_i     => SLOT_ROMHn,
        romln_i     => SLOT_ROMLn,
        io1n_i      => SLOT_IO1n,
        io2n_i      => SLOT_IO2n,
                
        -- local bus side
        mem_inhibit => memctrl_inhibit,
        mem_req     => mem_req,
        mem_resp    => mem_resp,
                 
        -- Audio outputs
        audio_speaker   => audio_speaker,
        audio_left      => audio_left,
        audio_right     => audio_right,
        speaker_vol     => speaker_vol,
        
        -- IEC bus
        iec_reset_i => IEC_RESET,
        iec_atn_i   => IEC_ATN,
        iec_data_i  => IEC_DATA,
        iec_clock_i => IEC_CLOCK,
        iec_srq_i   => IEC_SRQ_IN,
                                  
        iec_reset_o => open,
        iec_atn_o   => iec_atn_o,
        iec_data_o  => iec_data_o,
        iec_clock_o => iec_clock_o,
        iec_srq_o   => iec_srq_o,
                                    
        MOTOR_LEDn  => led_n(0),
        DISK_ACTn   => led_n(1),
        CART_LEDn   => led_n(2),
        SDACT_LEDn  => led_n(3),

        -- Debug UART
        UART_TXD    => uart_txd_from_logic,
        UART_RXD    => UART_RXD,
        
        -- SD Card Interface
        SD_SSn      => open,
        SD_CLK      => open,
        SD_MOSI     => open,
        SD_MISO     => '1',
        SD_CARDDETn => '1',
        SD_DATA     => open,
        
        -- RTC Interface
        RTC_CS      => open,
        RTC_SCK     => open,
        RTC_MOSI    => open,
        RTC_MISO    => '1',
    
        -- Flash Interface
        FLASH_CSn   => FLASH_CSn,
        FLASH_SCK   => FLASH_SCK,
        FLASH_MOSI  => FLASH_MOSI,
        FLASH_MISO  => FLASH_MISO,
    
        -- USB Interface (ULPI)
        ULPI_NXT    => ULPI_NXT,
        ULPI_STP    => ULPI_STP,
        ULPI_DIR    => ULPI_DIR,
        ULPI_DATA   => ULPI_DATA,
    
        -- Cassette Interface
        CAS_MOTOR   => CAS_MOTOR,
        CAS_SENSE   => CAS_SENSE,
        CAS_READ    => CAS_READ,
        CAS_WRITE   => CAS_WRITE,
        
        -- Ethernet Interface (RMII)
        eth_clock   => RMII_REFCLK, 
        eth_reset   => eth_reset,
        rmii_crs_dv => RMII_CRS_DV, 
        rmii_rxd    => RMII_RX_DATA,
        rmii_tx_en  => RMII_TX_EN,
        rmii_txd    => RMII_TX_DATA,

        -- Buttons
        BUTTON      => button_i );

    SLOT_RSTn <= '0' when RSTn_out = '0' else 'Z';
    SLOT_ADDR <= slot_addr_o when slot_addr_t = '1' else (others => 'Z');
    SLOT_DATA <= slot_data_o when slot_data_t = '1' else (others => 'Z');
    SLOT_RWn  <= slot_rwn_o  when slot_addr_t = '1' else 'Z';

    irq_push: entity work.oc_pusher port map(clock => sys_clock, sig_in => irq_oc, oc_out => SLOT_IRQn);
    nmi_push: entity work.oc_pusher port map(clock => sys_clock, sig_in => nmi_oc, oc_out => SLOT_NMIn);
    dma_push: entity work.oc_pusher port map(clock => sys_clock, sig_in => dma_oc, oc_out => SLOT_DMAn);
    exr_push: entity work.oc_pusher port map(clock => sys_clock, sig_in => exrom_oc, oc_out => SLOT_EXROMn);
    gam_push: entity work.oc_pusher port map(clock => sys_clock, sig_in => game_oc, oc_out => SLOT_GAMEn);
    
    LED_MOTORn <= led_n(0) xor sys_reset;
    LED_DISKn  <= led_n(1) xor sys_reset;
    LED_CARTn  <= led_n(2) xor sys_reset;
    LED_SDACTn <= led_n(3) xor sys_reset;

    IEC_SRQ_IN <= '0' when iec_srq_o   = '0' or sw_iec_o(3) = '0' else 'Z';
    IEC_ATN    <= '0' when iec_atn_o   = '0' or sw_iec_o(2) = '0' else 'Z';
    IEC_DATA   <= '0' when iec_data_o  = '0' or sw_iec_o(1) = '0' else 'Z';
    IEC_CLOCK  <= '0' when iec_clock_o = '0' or sw_iec_o(0) = '0' else 'Z';

    sw_iec_i <= IEC_SRQ_IN & IEC_ATN & IEC_DATA & IEC_CLOCK;

    button_i <= not BUTTON;

    ULPI_RESET <= por_n;
    UART_TXD <= uart_txd_from_logic; -- and uart_txd_from_qsys;

    i_pwm0: entity work.sigma_delta_dac --delta_sigma_2to5
    generic map (
        g_left_shift => 2,
        g_divider => 10,
        g_width => audio_speaker'length )
    port map (
        clock   => sys_clock,
        reset   => sys_reset,
        
        dac_in  => audio_speaker,
    
        dac_out => SPEAKER_DATA );

    b_audio: block
        signal audio_get_sample : std_logic;
        signal sys_get_sample   : std_logic;
        signal stream_out_data  : std_logic_vector(23 downto 0);
        signal stream_out_tag   : std_logic_vector(0 downto 0);
        signal stream_out_valid : std_logic;
        signal stream_in_data   : std_logic_vector(23 downto 0);
        signal stream_in_tag    : std_logic_vector(0 downto 0);
        signal stream_in_ready  : std_logic;
        signal audio_left_filt  : signed(17 downto 0);
        signal audio_right_filt : signed(17 downto 0);
        signal audio_audio_left : std_logic_vector(audio_left_filt'range);
        signal audio_audio_right: std_logic_vector(audio_right_filt'range);
    begin
        i_filt_left: entity work.lp_filter
        port map (
            clock     => sys_clock,
            reset     => sys_reset,
            signal_in => audio_left(18 downto 1),
            low_pass  => audio_left_filt );
        
        i_filt_right: entity work.lp_filter
        port map (
            clock     => sys_clock,
            reset     => sys_reset,
            signal_in => audio_right(18 downto 1),
            low_pass  => audio_right_filt );

        i2s: entity work.i2s_serializer
        port map (
            clock            => audio_clock,
            reset            => audio_reset,
            i2s_out          => AUDIO_SDO,
            i2s_in           => AUDIO_SDI,
            i2s_bclk         => AUDIO_BCLK,
            i2s_fs           => AUDIO_LRCLK,
            stream_out_data  => stream_out_data,
            stream_out_tag   => stream_out_tag,
            stream_out_valid => stream_out_valid,
            stream_in_data   => stream_in_data,
            stream_in_tag    => stream_in_tag,
            stream_in_valid  => '1',
            stream_in_ready  => stream_in_ready );

        AUDIO_MCLK <= audio_clock;

        i_sync_get: entity work.pulse_synchronizer
        port map (
            clock_in  => audio_clock,
            pulse_in  => audio_get_sample,
            clock_out => sys_clock,
            pulse_out => sys_get_sample
        );
        

        i_sync_left: entity work.synchronizer_gzw
        generic map (
            g_width     => audio_left_filt'length,
            g_fast      => false
        )
        port map(
            tx_clock    => sys_clock,
            tx_push     => sys_get_sample,
            tx_data     => std_logic_vector(audio_left_filt),
            tx_done     => open,
            rx_clock    => audio_clock,
            rx_new_data => open,
            rx_data     => audio_audio_left
        );
        
        i_sync_right: entity work.synchronizer_gzw
        generic map (
            g_width     => audio_right_filt'length,
            g_fast      => false
        )
        port map(
            tx_clock    => sys_clock,
            tx_push     => sys_get_sample,
            tx_data     => std_logic_vector(audio_right_filt),
            tx_done     => open,
            rx_clock    => audio_clock,
            rx_new_data => open,
            rx_data     => audio_audio_right
        );
 
        process(audio_clock)
        begin
            if rising_edge(audio_clock) then
                audio_get_sample <= '0';
                if stream_in_ready = '1' then
                    if stream_in_tag(0) = '0' then
                        stream_in_tag(0) <= '1';
                        stream_in_data <= std_logic_vector(left_scale(signed(audio_audio_right), 1)) & "0000000";
                        audio_get_sample <= '1';
                    else
                        stream_in_tag(0) <= '0';
                        stream_in_data <= std_logic_vector(left_scale(signed(audio_audio_left), 1)) & "0000000";
                    end if;
                end if;
                if audio_reset = '1' then
                    stream_in_tag(0) <= '1';
                end if;
            end if; 
        end process;
    end block;    
    
    SLOT_BUFFER_ENn <= not buffer_en;
    

    b_cia: block
        signal cia2_port_a_i   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_port_a_o   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_port_a_t   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_port_b_i   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_port_b_o   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_port_b_t   : std_logic_vector(7 downto 0) := X"FF";
        signal cia2_sp_i       : std_logic := '1';
        signal cia2_sp_o       : std_logic := '1';
        signal cia2_sp_t       : std_logic := '1';
        signal cia2_cnt_i      : std_logic := '1';
        signal cia2_cnt_o      : std_logic := '1';
        signal cia2_cnt_t      : std_logic := '1';
        signal cia2_pc_o       : std_logic := '1';
        signal cia2_flag_i     : std_logic := '1';
        signal cia2_irq        : std_logic;
        
        signal cia2_clock       : std_logic;
        signal cia2_reset       : std_logic;
        signal cia2_read        : std_logic;
        signal cia2_write       : std_logic;
        signal cia2_rdata       : std_logic_vector(7 downto 0);
        signal bus_data_latch   : std_logic_vector(7 downto 0);
        
        signal read_d           : std_logic;
        signal read_error       : std_logic;
        signal nmi_error        : std_logic;
    begin
        cia2_write <= '1' when SLOT_RWn = '0' and SLOT_ADDR(15 downto 8) = X"DD" and SLOT_PHI2 = '1' else '0'; 
        cia2_read  <= '1' when SLOT_RWn = '1' and SLOT_ADDR(15 downto 8) = X"DD" and SLOT_PHI2 = '1' else '0'; 
        cia2_clock <= not SLOT_PHI2;

        process(cia2_clock)
        begin
            if rising_edge(cia2_clock) then
                cia2_reset <= not SLOT_RSTn;
                bus_data_latch <= SLOT_DATA;
                read_d <= cia2_read;
            end if;
        end process;

        process(SLOT_PHI2)
        begin
            if rising_edge(SLOT_PHI2) then
                if cia2_rdata /= bus_data_latch and read_d = '1' then
                    read_error <= '1';
                else
                    read_error <= '0';
                end if;
            end if;
        end process;

        nmi_error <= cia2_irq xnor SLOT_NMIn;

        dummy <= or_reduce(nmi_error & read_error & cia2_rdata);

        i_cia2: entity work.cia_registers
        generic map (
            g_unit_name => "CIA_2" )
        port map (
            clock       => cia2_clock,
            rising      => '0',
            falling     => '1',
            reset       => cia2_reset,
            
            addr        => unsigned(SLOT_ADDR(3 downto 0)),
            wen         => cia2_write,
            ren         => cia2_read,
            data_out    => cia2_rdata,
            data_in     => SLOT_DATA,
        
            -- pio --
            port_a_o    => cia2_port_a_o,
            port_a_t    => cia2_port_a_t,
            port_a_i    => cia2_port_a_i,
            
            port_b_o    => cia2_port_b_o,
            port_b_t    => cia2_port_b_t,
            port_b_i    => cia2_port_b_i,
        
            -- serial pin
            sp_o        => cia2_sp_o,
            sp_i        => cia2_sp_i,
            sp_t        => cia2_sp_t,
            
            cnt_i       => cia2_cnt_i,
            cnt_o       => cia2_cnt_o,
            cnt_t       => cia2_cnt_t,
            
            tod_pin     => '0',
            pc_o        => cia2_pc_o,
            flag_i      => cia2_flag_i,
            
            irq         => cia2_irq );
    
        cia2_port_a_i(7) <= (cia2_port_a_o(7) or not cia2_port_a_t(7)) and IEC_DATA;  
        cia2_port_a_i(6) <= (cia2_port_a_o(6) or not cia2_port_a_t(6)) and IEC_CLOCK;  
        cia2_port_a_i(5) <= (cia2_port_a_o(5) or not cia2_port_a_t(5));  
        cia2_port_a_i(4) <= (cia2_port_a_o(4) or not cia2_port_a_t(4));  
        cia2_port_a_i(3) <= (cia2_port_a_o(3) or not cia2_port_a_t(3));  
        cia2_port_a_i(2) <= (cia2_port_a_o(2) or not cia2_port_a_t(2));  
        cia2_port_a_i(1) <= (cia2_port_a_o(1) or not cia2_port_a_t(1));  
        cia2_port_a_i(0) <= (cia2_port_a_o(0) or not cia2_port_a_t(0));  

        cia2_port_b_i <= cia2_port_b_o or not cia2_port_b_t;

        cia2_cnt_i <= cia2_cnt_o or not cia2_cnt_t;
        cia2_sp_i  <= cia2_sp_o  or not cia2_sp_t;
    
    end block;    
    
end architecture;
