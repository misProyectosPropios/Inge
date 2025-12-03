import random

def generar_strings(abecedario, largo_string, cantidad, archivo_salida):
    with open(archivo_salida, "w", encoding="utf-8") as f:
        for _ in range(cantidad):
            s = ''.join(random.choice(abecedario) for _ in range(largo_string))
            f.write(s + "\n")


# Ejemplo de uso
abecedario = "abc"           # el abecedario que quieras
largo = 5                    # largo de cada string
cantidad = 10                # cuántos strings generar
archivo = "salida.txt"       # archivo donde escribirlos

generar_strings(abecedario, largo, cantidad, archivo)
print("Strings generados y guardados en", archivo)