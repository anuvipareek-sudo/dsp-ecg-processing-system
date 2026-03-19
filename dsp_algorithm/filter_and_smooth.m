function v_smooth = filter_and_smooth(quantized_signal)
    % --- 1. Define Filter Window ---
    % For 125Hz, a 5-sample window is ~40ms, which smoothes noise 
    % without "crushing" the sharp R-peak.
    window_size = 5; 
    
    % --- 2. Implement the Filter ---
    % This simulates the DSP "Smoothing" inside the MSP430
    v_filtered = filter(ones(1, window_size)/window_size, 1, quantized_signal);
    
    % --- 3. Compensation for Filter Lag (Crucial for Engineers!) ---
    % Filters introduce a small time delay. To align the plots, we shift it.
    delay = floor(window_size / 2);
    v_smooth = [v_filtered(delay+1:end); zeros(delay, 1)];
end