function [quantized_signal, q_error, q_error_lsb] = quantize(v_adc_in, Vref)
    % Simulate the quantized signal
    adc_levels = 2^12; 
    quantized_signal = round((v_adc_in/Vref) * (adc_levels - 1));
    
    % Calculate the "Quantization Error"
    % Reconstructed voltage using quantized signal
    v_reconstructed = (quantized_signal / (adc_levels - 1)) * Vref;
    
    %the error: signal lost due to quantization
    q_error = v_adc_in - v_reconstructed;

    % Calculate LSB size
    lsb_size = Vref / (adc_levels - 1);
    
    % Convert error from Volts to "Number of Bits"
    q_error_lsb = q_error / lsb_size;
end