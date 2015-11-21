ram_width = 8;
data_width = 12; % including sign
% N = data_width - 1;
% x = linspace(0,2*pi,2^ram_width);
% y = ceil((2^N - 1)*sin(x));
y = [0:1:2^ram_width-1];
% plot(x,y)

hex_y = ndec2hex(y,data_width);
[m,hex_length] = size(hex_y)

fileID = fopen('ram.sv','w');
writeHeaderRAM(fileID,ram_width,data_width)
for i=0:1:2^ram_width-1
    % fprintf(fileID,'    assign mem[%d] = %d''h%s;\n',i,data_width,hex_y[i]);
    fprintf(fileID,'        mem[%d] = %d''h%s;\n',i,data_width,hex_y(i+1,1:hex_length));
end
fprintf(fileID,'    end\n');
fprintf(fileID,'\nendmodule\n');

