import argparse

parser = argparse.ArgumentParser(description='Transform file to libsmv format')
parser.add_argument(
    '--data',
    '-d',
    dest='dataPath',
    action='store',
    required=True,
    help='path to data'
)
args = parser.parse_args()

archivo_origen = args.dataPath
texto = ""
texto_test = ""
texto_train = ""
palabra = ""
f = open(archivo_origen, "r")
for y in f:
    fila_lista = y.split()
    #recorro la lista
    i=0
    renglon_comp = ""
    renglon_parc = ""
    for x in fila_lista:
        #concateno
	if i == 0:
		palabra = x
	        renglon_comp = x
		if (("v" in palabra) or ("u" in palabra)):
			renglon_parc = "-1"
		if (("w" in palabra) or ("x" in palabra)):
			renglon_parc = "+1"
	else:
	        renglon_comp = renglon_comp + " " + str(i) + ":" + x
	        renglon_parc = renglon_parc + " " + str(i) + ":" + x
        i=i+1
    #voy acumulando los renglones
    texto = texto + renglon_comp + "\n"
    #testing con ui y xi
    if (("u" in palabra) or ("x" in palabra)):
	texto_test = texto_test + renglon_parc + "\n"
    elif (("v" in palabra) or ("w" in palabra)):
	texto_train = texto_train + renglon_parc +"\n"


f.close()

#grabo el nuevo archivo
archivo_destino = archivo_origen + '_libsmv'
with open(archivo_destino, 'w') as file:
    file.write(texto)


archivo_destino = archivo_origen + '.train'
with open(archivo_destino, 'w') as file:
    file.write(texto_train)
archivo_destino = archivo_origen + '.test'
with open(archivo_destino, 'w') as file:
    file.write(texto_test)

