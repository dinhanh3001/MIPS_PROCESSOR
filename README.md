# MIPS_PROCESSOR-
Bộ vi xử lý MIPS với 8 lệnh cơ bản ADD, SUB, AND, OR, SLT, LW, SW, BEQ 
# DATAPATHS: 
<img width="668" height="488" alt="image" src="https://github.com/user-attachments/assets/d7d3ebd3-6b01-4f5d-95cd-5d493196aa27" />

# QUY ƯỚC THIẾT KẾ: 
- MẠCH TỔ HỢP: ALU/ADD/MUX
- MẠCH TUẦN TỰ: instruction/data memories và thanh ghi
- Tín hiệu điều khiển (Control signal)
- Tín hiệu dữ liệu (Data signal)
# TỔNG QUAN CÁC LỆNH CẦN XÉT: 
- Nhóm lệnh tham khảo bộ nhớ (lw và sw): lw $s1, 20($s2)
Nạp lệnh → Đọc một thanh ghi → Sử dụng ALU → Truy xuất bộ nhớ để đọc/ghi dữ liệu → Ghi 
dữ liệu vào thanh ghi 
- Nhóm lệnh logic và số học (add, sub, AND, OR, và slt) : add $t0, $s1, $s2
 Nạp lệnh → Đọc hai thanh ghi → Sử dụng ALU → Ghi dữ liệu vào thanh ghi
- Nhóm lệnh rẽ nhánh (beq): beq $s1, $s2, Exit (PC = Exit: hoặc PC = PC + 4)
 Nạp lệnh → Đọc hai thanh ghi → Sử dụng ALU → Chuyển đến địa chỉ lệnh tiếp theo dựa trên kết 
quả so sánh
# QUY TRÌNH THỰC THI LỆNH CỦA MIPS ( 5 CÔNG ĐOẠN ) 
<img width="1035" height="415" alt="image" src="https://github.com/user-attachments/assets/326e4e5b-e9e3-47aa-910f-2a9df867f211" />

- Giai đoạn nạp lệnh: sử dụng thanh ghi PC để tìm nạp lệnh từ bộ nhớ và sau đó tăng lên 4 đơn vị để lấy địa chỉ lệnh tiếp theo. ( giai đoạn này cần module PC, INSTRUCTION MEMORY, bộ cộng 4 (32 bít )
- Giai đoạn giải mã lênh: Lấy nội dung dữ liệu trong trường của lệnh ( đọc opcode để xác định kiểu lệnh và chiều dài từng trường trong mã máy). Giai đoạn này cần thiết kế các khối MUX, REGISTER FILE, SIGN-EXTEND.
- Giai đoạn tính toán ( ALU)
  sau khi đã xác định được kiểu lệnh và giá trị được lấy từ thanh ghi tương ứng sẽ được đưa vào khối tính toán.
 * lệnh Số học (Arithmetic) (ví dụ: add, sub), Logic (ví dụ: and, or): ALU tính ra kết quả cuối cùng
 * Lệnh làm việc với bộ nhớ (ví dụ: lw, sw): ALU dùng tính toán địa chỉ của bộ nhớ
 * Lệnh nhảy/nhánh (ví dụ: bne, beq): ALU thực hiện so sánh các giá trị trên thanh ghi và tính toán địa 
chỉ đích sẽ nhảy tới
khối control ALU được thiết kế như sau
<img width="433" height="471" alt="image" src="https://github.com/user-attachments/assets/65b2e34b-81ef-4aa5-a6c9-124e826bca58" />


