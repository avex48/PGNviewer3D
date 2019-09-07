extends Node2D

var bianco
var nero
var risultato
var cr
var numero_mosse
var mosse_uci=[]
var mosse_pgn=[]
var os
# Called when the node enters the scene tree for the first time.
func _ready():
    var userpath=OS.get_user_data_dir()
    # print(userpath)
    var directory = Directory.new()
    os=OS.get_name()
    # print(os)
    if not directory.dir_exists("user://temp"):
        directory = Directory.new( )
        directory.make_dir("user://temp")
        if os=="X11":
            var dir = Directory.new()
            var r=dir.copy("res://temp/current.pgn","user://temp/current.pgn")
            # r=dir.copy("res://temp/pgn-extract","user://temp/pgn-extract")
            # r=dir.copy("res://temp/pgn_x11.sh","user://temp/pgn_x11.sh")
        elif os=="Windows":
            var dir = Directory.new()
            var r=dir.copy("res://temp/current.pgn","user://temp/current.pgn")
            r=dir.copy("res://temp/pgn-extract.exe","user://temp/pgn-extract.exe")
            r=dir.copy("res://temp/pgn_win.bat","user://temp/pgn_win.bat")
        else:
            print("sistema operativo non supportato. Premi F8 per uscire...")


#    # DEVO SOPPRIMERE I COMMENTI CON DAL PGN (-C -N -V)

    noAnnotations() # Crea il file current.uci e il file moves.pgn
    leggo_uci()
    scriviFileVars()
    leggo_pgn()


func leggo_uci():
    var partita=crea_array_uci()
#    print("partita= ",partita)
#    print(typeof(partita))
    for i in len(partita)-1:
        var linea=partita[i]
        var pp=partita[i+1]
        if linea=="":
            mosse_uci=pp
            break

        if linea.begins_with ( '[White "'):
            bianco=linea.lstrip('[White "')
            bianco=bianco.left(len(bianco)-2)
        if linea.begins_with ( '[Black "'):
            nero=linea.lstrip('[Black "')
            nero=nero.left(len(nero)-2)
        if linea.begins_with ( '[Result "'):
            risultato=linea.lstrip('[Result "')
            risultato=risultato.left(len(risultato)-2)

    mosse_uci=mosse_uci.rsplit(" ")
    mosse_uci.remove (len(mosse_uci)-1)
    numero_mosse=(len(mosse_uci))
    var file = File.new()
    file.open("user://temp/_listamosse", File.WRITE)
    for i in len(mosse_uci):
        var m=mosse_uci[i]
        var da= m.left(2)
        var a=  m.right(2)
        file.store_string(da+"\n")  
        file.store_string(a+"\n")     
    file.close()

func leggo_pgn():
    var spazio
    var flag=0
    var partita=crea_array_pgn()
    var mosse_pgn=""
    for i in len(partita):
        var linea=partita[i]
        if linea == "" or linea== null:
            break
        mosse_pgn=mosse_pgn+linea+" "
    mosse_pgn=mosse_pgn.split(" ",true, 0)
    mosse_pgn.remove (numero_mosse)
    var file = File.new()
    file.open("user://temp/_list_mosse", File.WRITE)
    for i in len(mosse_pgn):
        file.store_string(str(mosse_pgn[i])+"\n")      
    file.close()

func crea_array_uci():
    var f_uci="user://temp/current.uci"
    var vars=read_vars(f_uci)
    return vars
    
func crea_array_pgn():
    var f_pgn="user://temp/moves.pgn"
    var vars=read_vars(f_pgn)
    return vars

func read_vars(file_name):
    var file = File.new()
    if !file.file_exists(file_name):
        return
    file.open(file_name, File.READ)
    var array = []
    while(!file.eof_reached()):
        var line = file.get_line()
        array.push_back(line)
    file.close()
    return array
    
func scriviFileVars():
    var file = File.new()
    file.open("user://temp/_varsGodot", File.WRITE)
    file.store_string(str(numero_mosse)+"\n")
    file.store_string(bianco+"\n")
    file.store_string(nero+"\n")
    file.store_string(risultato+"\n")
    file.close()
    
func noAnnotations():
    var user_temp=OS.get_user_data_dir()+"/temp"
    var file_pgn=str(user_temp+"/current.pgn")
    var array =  [file_pgn]
    var args = PoolStringArray(array)
    var output = []
    if os=="Windows":
        var r=OS.execute(user_temp+'/pgn_win.bat',[], true, output)
        print("132 --- ",r," ",user_temp+'/pgn_win.bat')
        print("133 --- ",r," ",args)
    elif os=="X11": 
        var r=OS.execute('pgn_x11.sh',args, true, output)

