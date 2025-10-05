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
<img width="655" height="389" alt="image" src="https://github.com/user-attachments/assets/9f98fe89-ddaa-4d5b-96f1-c0fda94df18b" />

  RegDst dùng để chọn thanh ghi đích cho thao tác ghi:
- RegDst = 0: Các bit từ 16:20 được chọn (rt - dành cho lệnh loadword)
- RegDst = 1: Các bit từ 11:15 được chọn (rd - dành cho các lệnh còn lại như add, sub, and, or, slt)
- Lệnh sw và beq không sử dụng giá trị này
<img width="579" height="398" alt="image" src="https://github.com/user-attachments/assets/4bb500d0-df9b-4298-855d-08ffed4eb14f" />

RegWrite dùng để cho phép thao tác ghi vào khối thanh ghi: 
- RegWrite = 0: Khối thanh ghi chỉ có chức năng đọc (dành cho các lệnh sw và beq)
- RegWrite = 1: Khối thanh ghi có thể thực hiện chứ năng đọc và ghi. Thanh ghi được ghi là thanh ghi có chỉ số được đưa vào từ ngõ “Write register” và dữ 
liệu dùng ghi vào thanh ghi này được lấy từ ngõ “Write data” (dành cho các lệnh còn lại

<img width="627" height="392" alt="image" src="https://github.com/user-attachments/assets/52f2fbe9-d6fa-45f1-add3-418a1deb1064" />

ALUSrc dùng để chọn đầu vào thứ 2 cho khối ALU: 
- ALUSrc = 0: Đầu vào thứ 2 cho ALU đến từ “Read data 2” của khối “Registers (dành cho các lệnh add, sub, and, or, slt, beq)
- ALUSrc = 1: Đầu vào thứ 2 cho ALU đến từ output của khối “Signextend” (dành cho các lệnh còn lại như lw và sw)

<img width="587" height="387" alt="image" src="https://github.com/user-attachments/assets/56b7ce1e-e037-4a25-ada8-f936a1b3963b" />

 Branch dùng để kết hợp (AND) với giá trị Zero của ALU chọn giá trị sẽ được nạp vào thanh ghi PC:
 - Branch = 0: Giá trị của PC đến từ khối Add (4) PC = PC + 4 (dành cho các lệnh add, sub, and, or, slt, lw, sw)
 - - Branch = 1: Tùy thuộc vào giá trị của Zero của khối ALU (dành cho lệnh beq).
 Nếu Zero = 0: Giá trị của PC đến từ khối Add (4) PC = PC + 4
 Nếu Zero = 1: Giá trị của PC đến từ khối Add (Shift left 2) PC = PC + 4 + Lable

<img width="602" height="412" alt="image" src="https://github.com/user-attachments/assets/f8e6debb-fcb6-4c64-8ead-d607e9d2404f" />
MemRead dùng để cho phép thao tác đọc từ khối Data memory: 
- MemRead = 1: Khối “Data memory” thực hiện chức năng đọc dữ liệu. Địa chỉ dữ liệu cần đọc được đưa vào từ ngõ “Address” và nội dung đọc được 
xuất ra ngõ “Read data” (dành cho lệnh lw)
- MemRead = 0: Khối “Data memory” không thực hiện chức năng đọc dữ liệu (dành cho các lệnh còn lại)

<img width="618" height="402" alt="image" src="https://github.com/user-attachments/assets/2011a1b5-3a7e-4241-add1-db44d07330f1" />
MemWrite dùng để cho phép thao tác ghi vào khối Data memory:
- MemWrite = 1: Khối “Data memory” thực hiện chức năng ghi dữ liệu. Địa chỉ dữ liệu cần ghi được đưa vào từ ngõ “Address” và nội dung ghi vào lấy từ ngõ “Write data” (dành cho 
lệnh sw)
- MemWrite = 0: Khối “Data memory” không thực hiện chức năng ghi dữ liệu (dành cho các lệnh còn lại)

<img width="615" height="428" alt="image" src="https://github.com/user-attachments/assets/cdcfc4ac-fc5f-47f6-9e3f-6ae01e09d1f6" />

 MemtoReg dùng để chọn giá trị được đưa vào ngõ Write data của khối Registers:
 - MemtoReg = 0: Giá trị đưa vào ngõ “Write data” đến từ ALU (dành cho các lệnh add, sub, and, or, slt)
- MemtoReg = 1: Giá trị đưa vào ngõ “Write data” đến từ khối “Data memory” (dành cho lệnh lw)- Lệnh sw và beq không sử dụng giá trị này
# KIỂM TRA HOẠT ĐỘNG CỦA THIẾT KẾ. 
