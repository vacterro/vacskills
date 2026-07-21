<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Инструкция SAIPEN (Версия Деда 👴)

Слышь, салажнюк. Чо расплёлся? Проблема у тебя одна: твои нейросети тупые как пробка и забывают всё через пять минут.

**SAIPEN** — это брезентовый планшет в папке `.saipen/` прямо у тебя в проекте.

## Шевелись

1. **Запихай правила в комп:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Вруби в проекте:**
> `saipen set`

3. **Паши:**
> `saipen`

## Приказы

| Команда | Чо делает |
|---|---|
| `saipen set` | Создать папку `.saipen/` (мозги) |
| `saipen continue` | Прочитать мозги и пахать |
| `saipen stop` | Тормознуть и записать где стал |
| `saipen status` | Глянуть че там по плану |
| `saipen goal <text>` | Закинуть новую хотелку |
| `saipen clean` | Вынести мусор |
| `saipen translate` | Отправить батрака переводить |
| `saipen ship` | Выкатить в прод |
