<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN गाइड (हिन्दी)

सुनो, नौसिखिए। समस्या सरल है: आपके AI एजेंटों की याददाश्त गोल्डफिश जैसी है।

**SAIPEN** आपके प्रोजेक्ट में `.saipen/` फ़ोल्डर के अंदर एक नोटबुक है।

## त्वरित शुरुआत

1. **प्रति मशीन एक बार इंस्टॉल करें:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **प्रोजेक्ट शुरू करें:**
> `saipen set`

3. **काम:**
> `saipen`

## कमांड

| कमांड | कार्रवाई |\n|---|---|\n| `saipen set` | मेमोरी फ़ोल्डर प्रारंभ करें |\n| `saipen continue` | नोट्स से काम फिर से शुरू करें |\n| `saipen stop` | प्रगति सहेजें और रुकें |\n| `saipen status` | बोर्ड पढ़ें |\n| `saipen goal <text>` | नए लक्ष्य की ओर बढ़ें |\n| `saipen clean` | रिपॉजिटरी साफ़ करें |\n| `saipen translate` | अनुवाद निर्माण |\n| `saipen ship` | रिलीज़ प्रवाह ट्रिगर करें |
