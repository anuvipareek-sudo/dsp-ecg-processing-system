function v_adc_in = pre_processing(raw_ecg, Vref)
    % 1. Remove DC Offset (Detrending)
    % In hardware, this is a High-Pass Filter (cutoff ~0.5Hz)
    clean_ecg = raw_ecg - mean(raw_ecg);
    
    % 2. Rectify/Flip
    % If the downward spike is the R-peak, we flip it.
    if abs(min(clean_ecg)) > max(clean_ecg)
        clean_ecg = -clean_ecg;
    end
    
    % 3. Bias and Gain (The "INA118" Stage)
    Vref = 3.3; 
    signal_span = max(clean_ecg) - min(clean_ecg);
    gain = (Vref * 0.8) / signal_span; 
    
    % 4. Centering the final input to ADC
    % We add Vref/2 to center the signal at 1.65V
    v_adc_in = (clean_ecg * gain) + (Vref / 2); 
    
    % 5. Hardware Clipping (Safety check)
    v_adc_in = max(0, min(v_adc_in, Vref));
end