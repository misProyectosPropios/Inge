rangos = set()

class Rango:
    def __init__(self, min, max):
        self.min = min
        self.max = max

    def cantidadDeValoresEnRango(self):
        return self.max - self.min + 1

    def estaEnRango(self, valor):
        return self.min <= valor and self.max >= valor

    def maximo(self):
        return self.max

    def minimo(self):
        return self.min
    
    def __str__(self):
        return f'rango entre: {self.min} - {self.max}'

    def intersectaConRango(self, rango):
        maximoRango = rango.maximo()
        minimoRango = rango.minimo()
        return rango.estaEnRango(self.max) or rango.estaEnRango(self.min) or self.estaEnRango(minimoRango) or self.estaEnRango(maximoRango)

    def unir_rangos(self, rango):
        maximoRango = rango.maximo()
        minimoRango = rango.minimo()
        if self.intersectaConRango(rango) : # preguntar si el extremo del rango esta dentro
            maximoNuevo = max(self.max, rango.maximo())
            minimoNuevo = min(self.min, rango.minimo())
            return Rango(minimoNuevo, maximoNuevo)
        else:
            return (self, rango)

with open("input.txt") as f:
    for linea in f:
        lineaSinUltimo = linea[:-1] 
        v = lineaSinUltimo.split('-') 
        rango = Rango(int(v[0]), int(v[1]))
        rangos.add(rango)


rangosSinInterseccion = set()

def todosElementosNoIntersecan():
    if len(rangosSinInterseccion) == 0:
        return False
    for rango in rangosSinInterseccion:
        for rangoAVerificar in rangosSinInterseccion:
            if rango != rangoAVerificar and rango.intersectaConRango(rangoAVerificar):
                return False 
    return True

def intersecaConAlguno(rango, rangos):
    for rangoComp in rangos:
        if rango != rangoComp and rango.intersectaConRango(rangoComp):
            return True 
    return False 

while len(rangos) != 0:
    rangoPop = rangos.pop()
    rangosASacar = set()
    for rango in rangos:   
        if rangoPop.intersectaConRango(rango):
            rangosASacar.add(rango)
           
    for sacar in rangosASacar:
        rangos.remove(sacar)
        rangoPop = rangoPop.unir_rangos(sacar)

    if intersecaConAlguno(rangoPop, rangos):
        rangos.add(rangoPop)
    else:
        rangosSinInterseccion.add(rangoPop)

for ran in rangosSinInterseccion:
    print(ran)

sumaValores = 0
for x in rangosSinInterseccion:
    sumaValores = sumaValores + x.cantidadDeValoresEnRango()

print(sumaValores)
