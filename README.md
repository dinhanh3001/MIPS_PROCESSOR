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
  lệnh Số học (Arithmetic) (ví dụ: add, sub), Logic (ví dụ: and, or): ALU tính ra kết quả cuối cùng
  Lệnh làm việc với bộ nhớ (ví dụ: lw, sw): ALU dùng tính toán địa chỉ của bộ nhớ
  Lệnh nhảy/nhánh (ví dụ: bne, beq): ALU thực hiện so sánh các giá trị trên thanh ghi và tính toán địa 
chỉ đích sẽ nhảy tới
khối control ALU được thiết kế dựa vào 6 bít trường opcode và 2 bít được sinh ra từ khối CONTROL ( sẽ đề cập sau) 
<img width="433" height="471" alt="image" src="https://github.com/user-attachments/assets/65b2e34b-81ef-4aa5-a6c9-124e826bca58" />

- Giai đoạn truy xuất vùng nhớ:
 Chỉ có lệnh Load và Store cần thực hiện các thao tác trong giai đoạn này:
 Sử dụng địa chỉ vùng nhớ được tính toán ở giai đoạn ALU
 Đọc dữ liệu ra hoặc ghi dữ liệu vào vùng nhớ dữ liệu
Tất cả các lệnh khác sẽ rảnh trong giai đoạn này
<img width="1033" height="443" alt="image" src="https://github.com/user-attachments/assets/d5de3cce-565a-4dcd-a6cf-87522179c9ee" />

- Giai đoạn lưu trữ kết quả:
Những lệnh ghi kết quả của các phép toán vào thanh ghi:
 Ví dụ: số học, logic, shifts, load, set-less-than
Cần chỉ số thanh ghi đích và kết quả tính toán
Những lệnh không ghi kết quả như: store, branch, jump:
 Không có ghi kết quả
 ➔Những lệnh này sẽ rảnh trong giai đoạn này
<img width="1019" height="479" alt="image" src="https://github.com/user-attachments/assets/f1d56582-e331-4055-81cc-b8423a65d45d" />

# Khối control với các tín hiệu sau:
  RegDst dùng để chọn thanh ghi đích cho thao tác ghi:
- RegDst = 0: Các bit từ 16:20 được chọn (rt - dành cho lệnh loadword)
- RegDst = 1: Các bit từ 11:15 được chọn (rd - dành cho các lệnh còn lại như add, sub, and, or, slt)
- Lệnh sw và beq không sử dụng giá trị này

