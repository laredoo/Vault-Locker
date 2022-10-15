module cofre (x, clk, rst, y);
  input [1:0]x;
  input clk, rst;
    output reg y;
    
    //Registrador de estado
    reg [2:0] state; // 6 estados -> registrador de 3 bits

    //Codificacao dos estados
    parameter a = 3'b000,
              b = 3'b001,
              c = 3'b010,
              d = 3'b011,
              e = 3'b100,
              f = 3'b101;

    //Estado inicial
    initial begin
        state <= a; //porcao sequencial - atribuicao nao bloqueavel
    end

    //primeiro procedimento - estado proximo
    always @(negedge clk, negedge rst) begin
        if(rst == 1'b0) state <= a;
        else begin
            case(state)
                a: begin
                    if(x==2'b00) state <= a;
                    else if(x==2'b01) state <= b;
                end
                //A
                b: begin
                    if(x==2'b00) state <= b;
                    else if(x==2'b11) state <= c;
                    else if(x==2'b01) state <= b;
                    else if(x==2'b10) state <= a;
                end
                //AC
                c: begin
                    if(x==2'b00) state <= c;
                    else if(x==2'b01) state <= d;
                    else if(x==2'b10) state <= a;
                    else if(x==2'b11) state <= a;  
                end
                //ACA
                d: begin
                    if(x==2'b00) state <= d;
                    else if(x==2'b01) state <= e;
                    else if(x==2'b10) state <= a;
                    else if(x==2'b01) state <= c;
                end
                //ACAA
                e: begin
                    if(x==2'b00) state <= e;
                    else if(x==2'b01) state <= b;
                    else if(x==2'b10) state <= f;
                    else if(x==2'b11) state <= c;
                end
                f: begin
                    state <= f;
                end
            endcase
        end
    end

    //segundo procedimento 
    always @(state, x) begin //sensivel a entrada pois eh uma maquina de mealy
        case(state)
            a:begin
                y = 1'b0;
            end
            b:begin
                y = 1'b0;
            end
            c:begin
                y = 1'b0;
            end
            d:begin
                y = 1'b0;
            end
            e:begin
                if(x == 2'b10) y = 1'b1;
                else y = 1'b0;
            end
            f:begin
                y = 1'b1;
            end
        endcase
    end
endmodule
