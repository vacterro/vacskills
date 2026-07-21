<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Ръководство SAIPEN (Български)

Слушай, новобранец. Проблемът е прост: твоите AI агенти имат памет на златна рибка.

**SAIPEN** е бележник в папката `.saipen/` във вашия проект.

## Бърз старт

1. **Инсталирайте веднъж на машина:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Стартиране на проект:**
> `saipen set`

3. **Работа:**
> `saipen`

## Команди

| Команда | Действие |
|---|---|
| `saipen set` | Инициализиране на папка за памет |
| `saipen continue` | Възобновяване на работата от бележки |
| `saipen stop` | Запазване на напредъка и спиране |
| `saipen status` | Четене на таблото |
| `saipen goal <text>` | Преминаване към нова цел |
| `saipen clean` | Почистване на хранилището |
| `saipen translate` | Изграждане на превод |
| `saipen ship` | Стартиране на поток за пускане |
