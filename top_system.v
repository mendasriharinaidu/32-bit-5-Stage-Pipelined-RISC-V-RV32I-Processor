


module top_system (
    input  wire        clk,
    input  wire        start,
    
    // Final Receiver Demodulated Outputs
    output wire [1:0]  final_recovered_bits
   // output wire        recovered_valid,
   // output wire        recovered_last
);

    // --- Internal Routing Interconnect Wires ---
    wire [1:0]  w_lfsr_data;
    wire        w_lfsr_valid;
    
    wire        w_qpsk_valid;
    wire [7:0]  w_parallel_i;
    wire [7:0]  w_parallel_q;
    
    wire [15:0] w_stream_data;
    wire        w_stream_valid;
    wire        w_stream_last;
    
    wire [15:0] w_ifft_data;
    wire        w_ifft_valid;
    wire        w_ifft_last;

    wire [15:0] fft_rx_data;
    wire        fft_rx_valid;
    wire        fft_rx_last;

    // =========================================================================
    // BLOCK A: True LFSR (PRBS Data Generator)
    // =========================================================================
    lfsr u_lfsr (
        .clk(clk),
        .start(start),
        .parallel_out(w_lfsr_data),
        .symbol_valid(w_lfsr_valid)
    );

    // =========================================================================
    // BLOCK B: QPSK Modulator (Constellation Mapping)
    // =========================================================================
    qpsk_mod u_qpsk_mod (
        .clk(clk),
        .symbol_valid(w_lfsr_valid),
        .parallel_in(w_lfsr_data),
        .i(w_parallel_i),
        .q(w_parallel_q),
        .symbol_valid_out(w_qpsk_valid)
    );

    // =========================================================================
    // BLOCK C: AXI-Stream Formatter (16-bit packed: 8-bit Q + 8-bit I)
    // =========================================================================
    axi_stream u_axi_stream (
        .clk(clk),
        .symbol_valid(w_qpsk_valid),
        .i(w_parallel_i),
        .q(w_parallel_q),
        .t_data(w_stream_data),       
        .t_valid(w_stream_valid),
        .t_last(w_stream_last),
        .ifft_out(w_ifft_data),
        .ifft_valid_out(w_ifft_valid),
        .ifft_last_out(w_ifft_last)
    );

    // =========================================================================
    // UNIFIED CONFIGURATION HANDSHAKE LOGIC (For Both IP Cores)
    // =========================================================================
//    reg  config_valid = 1'b0;
//    reg  cfg_done     = 1'b0;
//    wire config_ready_0;
//    wire config_ready_1;

//    always @(posedge clk) begin
//        if (!start) begin
//            config_valid <= 1'b0;
//            cfg_done     <= 1'b0;
//        end else if (!cfg_done) begin
//            config_valid <= 1'b1;
//            // Drop valid ONLY when BOTH core engines acknowledge receipt
//            if (config_ready_0 && config_ready_1) begin
//                config_valid <= 1'b0;
//                cfg_done     <= 1'b1;
//            end
//        end else begin
//            config_valid <= 1'b0;
//        end
//    end
    
//    // =========================================================================
//    // BLOCK D: Transmitter IFFT IP Core (xfft_0)
//    // =========================================================================
//    xfft_0 u_iff_engine (
//        .aclk(clk),
        
//        .s_axis_config_tdata(8'h01),  // Bit 0 = 1 for IFFT
//        .s_axis_config_tvalid(config_valid), 
//        .s_axis_config_tready(config_ready_0), 

//        .s_axis_data_tdata(w_stream_data),   
//        .s_axis_data_tvalid(w_stream_valid), 
//        .s_axis_data_tlast(w_stream_last),   
//        .s_axis_data_tready(),               

//        .m_axis_data_tdata(w_ifft_data),   
//        .m_axis_data_tvalid(w_ifft_valid), 
//        .m_axis_data_tlast(w_ifft_last),   
//        .m_axis_data_tready(1'b1),           

//        .event_frame_started(),
//        .event_tlast_unexpected(),
//        .event_tlast_missing(),
//        .event_status_channel_halt(),
//        .event_data_in_channel_halt(),
//        .event_data_out_channel_halt()
//    );

    // =========================================================================
    // RECEIVER BLOCK G: Forward FFT IP Core (xfft_1)
    // =========================================================================
    
    
   
  // wire t_ready1;
    
//    reg  config_valid = 1'b0;
//    reg  cfg_done     = 1'b0;
//    wire config_ready_0;
//    wire config_ready_1;

//    always @(posedge clk) begin
//        if (!start) begin
//            config_valid <= 1'b0;
//            cfg_done     <= 1'b0;
//        end else if (!cfg_done) begin
//            config_valid <= 1'b1;
//            // Drop valid ONLY when BOTH core engines acknowledge receipt
//            if (config_ready_0 && config_ready_1) begin
//                config_valid <= 1'b0;
//                cfg_done     <= 1'b1;
//            end
//        end else begin
//            config_valid <= 1'b0;
//        end
//    end
    
    
//reg config_valid;
 
//reg cfg_done=0;

//wire config_ready_1;


//always @(posedge clk) begin
//    if(!cfg_done) begin
//        config_valid <= 1;
//        if(config_ready_1) begin
//            config_valid <= 0;
//            cfg_done <= 1;
//        end
//    end
//end
    
    
//    xfft_1 u_ff_engine (
//        .aclk(clk),
        
//        .s_axis_config_tdata(8'h00),     // Bit 0 = 0 for Forward FFT
//        .s_axis_config_tvalid(config_valid), 
//        .s_axis_config_tready(config_ready_1),

//        .s_axis_data_tdata(w_ifft_data),   
//        .s_axis_data_tvalid(w_ifft_valid), 
//        .s_axis_data_tlast(w_ifft_last),   
//        .s_axis_data_tready(t_ready1),               

//        .m_axis_data_tdata(fft_rx_data),   
//        .m_axis_data_tvalid(fft_rx_valid), 
//        .m_axis_data_tlast(fft_rx_last),   
//        .m_axis_data_tready(1'b1),           

//        .event_frame_started(),
//        .event_tlast_unexpected(),
//        .event_tlast_missing(),
//        .event_status_channel_halt(),
//        .event_data_in_channel_halt(),
//        .event_data_out_channel_halt()
//    );

    // =========================================================================
    // BLOCK H: QPSK Demodulator (Final Slicing Logic)
    // =========================================================================
    
    
    wire [7:0] I,Q;
    
    qpsk_demod u_qpsk_demod (
        .clk(clk),
        .w_ifft_data(w_ifft_data),
        .w_ifft_valid(w_ifft_valid),
        .w_ifft_last(w_ifft_last),
        .fft_rx_data(fft_rx_data),
        .fft_rx_valid(fft_rx_valid),
        .fft_rx_last(fft_rx_last),
        .bits_out(final_recovered_bits),
        .i(I),
        .q(Q)
    );

endmodule