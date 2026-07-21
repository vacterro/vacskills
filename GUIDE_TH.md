<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# คู่มือ SAIPEN (ไทย)

SAIPEN คือสมุดบันทึกในโฟลเดอร์ `.saipen/` สำหรับเอเจนต์ AI

## เริ่มต้นอย่างรวดเร็ว

1. **ติดตั้งเพียงครั้งเดียวต่อเครื่อง:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **เริ่มโปรเจ็กต์:**
> `saipen set`

3. **ทำงาน:**
> `saipen`

## คำสั่ง

| คำสั่ง | การกระทำ |
|---|---|
| `saipen set` | เริ่มต้นโฟลเดอร์หน่วยความจำ `.saipen/` |
| `saipen continue` | ดำเนินการทำงานจากบันทึก |
| `saipen stop` | บันทึกความคืบหน้า & หยุด |
| `saipen status` | อ่านกระดาน & สถานะ |
| `saipen goal <text>` | ปรับเปลี่ยนไปยังเป้าหมายใหม่ |
| `saipen clean` | ทำความสะอาดที่เก็บข้อมูลอย่างลึกซึ้ง |
| `saipen translate` | สร้างงานแปลภาษา 22 ภาษาแยกต่างหาก |
| `saipen ship` | เรียกใช้โฟลว์การเปิดตัว |
