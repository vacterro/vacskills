<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Guia SAIPEN (Português)

SAIPEN é um caderno de memória persistente na pasta `.saipen/` para agentes de IA.

## Início Rápido

1. **Instale uma vez por máquina:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Iniciar projeto:**
> `saipen set`

3. **Trabalhar:**
> `saipen`

## Comandos

| Comando | Ação |
|---|---|
| `saipen set` | Inicializar pasta de memória `.saipen/` |
| `saipen continue` | Retomar trabalho das notas |
| `saipen stop` | Salvar progresso e parar |
| `saipen status` | Ler quadro e estado |
| `saipen goal <text>` | Mudar para novo objetivo |
| `saipen clean` | Limpeza profunda do repositório |
| `saipen translate` | Construção isolada de tradução em 22 idiomas |
| `saipen ship` | Disparar fluxo de lançamento |
