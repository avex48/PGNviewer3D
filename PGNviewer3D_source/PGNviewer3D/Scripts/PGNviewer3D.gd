extends Spatial
                   ##################

var listamosse=[]    # lista mosse (lista di tuple :nome casa da , nome casa a)
var list_mosse=[]    # lista mosse come in PGN
var dizCscacchi={}   # Diz. delle coord. delle caselle chiave=numero casa, valore=tupla coord. (x,y,z)
var listEnPassant=[] # flag: 1 se la mossa è una presa es-passant, altrimenti 0 (zero)
var dizScacchiera = {}
var listPedoniBianchiPromossi=[]
var listPedoniNeriPromossi=[]
var listRegineBianchePromosse=[]
var listRegineNerePromosse=[]
var listTorriBianchePromosse=[]
var listTorriNerePromosse=[]
var listCavalliBianchiPromossi=[]
var listCavalliNeriPromossi=[]
var listAlfieriBianchiPromossi=[]
var listAlfieriNeriPromossi=[]
var listNeriPromossi=[]
var listBianchiPromossi=[]
var mosse_uci=[]
var mosse_pgn=[]

var casePrecedenti
var dizPromossiCattura            ={} # ---> chiave=nome_casa:valore=nome_pezzo_catturato
var dizPezziCattura               ={} # dizi. dei pezzi catturati ---> chiave=nome_casa:valore=nome_pezzo_catturato
var dizPromossiCatturaNeri        ={}
var dizPromossiCatturaBianchi     ={}
# var  dizNomiPromossi              ={} # ---> chiave=nome_pezzo_promosso : valore=nome_pezzo_catturato
var dizNomiPromossiCatturaBianchi ={}
var dizNomiPromossiCatturaNeri    ={}
var PezziCattura={}
var partite={}
var catt_bianco={} # pezzi catturati bianchi: chiave=casa, valore=nome_pezzo
var catt_nero={}   # pezzi catturati neri
var dizCcattura={} # lista delle coord. delle caselle pezzi catturati
var nmosse
var fine
var White
var Black
var Result
var iniziato
var enPassant
var textAudio = "Audio ON"
var audio=1
var pezzoCatturato
var CasaPrecedente
var posizione
var cattura
var mossa
var cr
var restart = 0
var num_mss = 0
var nomossa = 0
var arrocco = 0
var k=0.1 # coefficiente di scala
var lato=5.07  # dimensione in pixel del lato di una casa della scacchiera in centimetri
var avanti
var indietro
# Coordinate della casa A1 = x_base, y_base, z_base
var x_base=-17.751
var y_base=-17.751
var z_base=0
var promossoConPresa = "xxxx"
var pezzoPromosso    = "xxxx"
var zz=Vector3(0, -10, 0)   # zz=Vector3(0, 0, -10)
var nomePezzo
## e le variabili che contengono le coordinate x, y, z della posizione dei pezzi catturati (in centimetri)
## k e' il coefficiente di scala
var A1; var A2; var A3; var A4; var A5; var A6; var A7; var A8
var B1; var B2; var B3; var B4; var B5; var B6; var B7; var B8
var C1; var C2; var C3; var C4; var C5; var C6; var C7; var C8
var D1; var D2; var D3; var D4; var D5; var D6; var D7; var D8
var E1; var E2; var E3; var E4; var E5; var E6; var E7; var E8
var F1; var F2; var F3; var F4; var F5; var F6; var F7; var F8
var G1; var G2; var G3; var G4; var G5; var G6; var G7; var G8
var H1; var H2; var H3; var H4; var H5; var H6; var H7; var H8

var x_CN  = 303*k
var x1_CN = 251*k
var z_CN  = -12*k
var x_CB  =-303*k
var x1_CB = -251*k
var z_CB  = -12*k
var y_Cbase=0

#Coordinate delle 15 case pezzi catturati
var CtN1 =Vector3(x_CN,z_CN,  y_Cbase-(lato*0))
var CtB1 =Vector3(x_CB,z_CB,  y_Cbase-(lato*0))
var CtN2 =Vector3(x_CN,z_CN,  y_Cbase-(lato*1))
var CtB2 =Vector3(x_CB,z_CB,  y_Cbase-(lato*1))
var CtN3 =Vector3(x_CN,z_CN,  y_Cbase-(lato*2))
var CtB3 =Vector3(x_CB,z_CB,  y_Cbase-(lato*2))
var CtN4 =Vector3(x_CN,z_CN,  y_Cbase-(lato*3))
var CtB4 =Vector3(x_CB,z_CB,  y_Cbase-(lato*3))

var CtN5 =Vector3(x_CN,z_CN,  y_Cbase+(lato*3))
var CtB5 =Vector3(x_CB,z_CB,  y_Cbase+(lato*3))
var CtN6 =Vector3(x_CN,z_CN,  y_Cbase+(lato*2))
var CtB6 =Vector3(x_CB,z_CB,  y_Cbase+(lato*2))
var CtN7 =Vector3(x_CN,z_CN,  y_Cbase+(lato*1))
var CtB7 =Vector3(x_CB,z_CB,  y_Cbase+(lato*1))
var CtN8 =Vector3(x_CN,z_CN,  y_Cbase+(lato*0))
var CtB8 =Vector3(x_CB,z_CB,  y_Cbase+(lato*0))

var CtN9 =Vector3(x1_CN,z_CN, y_Cbase+(lato*0))
var CtB9 =Vector3(x1_CB,z_CB, y_Cbase+(lato*0))
var CtN10=Vector3(x1_CN,z_CN, y_Cbase+(lato*1))
var CtB10=Vector3(x1_CB,z_CB, y_Cbase+(lato*1))
var CtN11=Vector3(x1_CN,z_CN, y_Cbase+(lato*2))
var CtB11=Vector3(x1_CB,z_CB, y_Cbase+(lato*2))
var CtN12=Vector3(x1_CN,z_CN, y_Cbase+(lato*3))
var CtB12=Vector3(x1_CB,z_CB, y_Cbase+(lato*3))

var CtN13=Vector3(x1_CN,z_CN, y_Cbase+(-lato*3))
var CtB13=Vector3(x1_CB,z_CB, y_Cbase+(-lato*3))
var CtN14=Vector3(x1_CN,z_CN, y_Cbase+(-lato*2))
var CtB14=Vector3(x1_CB,z_CB, y_Cbase+(-lato*2))
var CtN15=Vector3(x1_CN,z_CN, y_Cbase+(-lato*1))
var CtB15=Vector3(x1_CB,z_CB, y_Cbase+(-lato*1))

#Coordinate delle 8+8 case pezzi promossi catturati
var xx_CN = 353*k
var xx_CB =-353*k
var CttN0 = Vector3(xx_CN, z_CN, y_Cbase-(lato*0))
var CttB0 = Vector3(xx_CB, z_CB, y_Cbase-(lato*0))
var CttN1 = Vector3(xx_CN, z_CN, y_Cbase-(lato*1))
var CttB1 = Vector3(xx_CB, z_CB, y_Cbase-(lato*1))
var CttN2 = Vector3(xx_CN, z_CN, y_Cbase-(lato*2))
var CttB2 = Vector3(xx_CB, z_CB, y_Cbase-(lato*2))
var CttN3 = Vector3(xx_CN, z_CN, y_Cbase-(lato*3))
var CttB3 = Vector3(xx_CB, z_CB, y_Cbase-(lato*3))

var CttN4 = Vector3(xx_CN, z_CN, y_Cbase+(lato*3))
var CttB4 = Vector3(xx_CB, z_CB, y_Cbase+(lato*3))
var CttN5 = Vector3(xx_CN, z_CN, y_Cbase+(lato*2))
var CttB5 = Vector3(xx_CB, z_CB, y_Cbase+(lato*2))
var CttN6 = Vector3(xx_CN, z_CN, y_Cbase+(lato*1))
var CttB6 = Vector3(xx_CB, z_CB, y_Cbase+(lato*1))
var CttN7 = Vector3(xx_CN, z_CN, y_Cbase+(lato*0))
var CttB7 = Vector3(xx_CB, z_CB, y_Cbase+(lato*0))

# dizPosizione ---> chiave=nome_casa:valore=NomePezzo
# la seguente e' la posizione iniziale dei pezzi
# Tutti quei Null in python erano "" (stringhe vuote) non so se così va bene!
var dizPosizione = {
"a1":"RA1","b1":"NB1","c1":"BC1","d1":"QD1","e1":"KE1","f1":"BF1","g1":"NG1","h1":"RH1",
"a2":"PA2","b2":"PB2","c2":"PC2","d2":"PD2","e2":"PE2","f2":"PF2","g2":"PG2","h2":"PH2",
"a3":null, "b3":null, "c3":null, "d3":null, "e3":null, "f3":null, "g3":null, "h3":null,
"a4":null, "b4":null, "c4":null, "d4":null, "e4":null, "f4":null, "g4":null, "h4":null,
"a5":null, "b5":null, "c5":null, "d5":null, "e5":null, "f5":null, "g5":null, "h5":null,
"a6":null, "b6":null, "c6":null, "d6":null, "e6":null, "f6":null, "g6":null, "h6":null,
"a7":"pA7","b7":"pB7","c7":"pC7","d7":"pD7","e7":"pE7","f7":"pF7","g7":"pG7","h7":"pH7",
"a8":"rA8","b8":"nB8","c8":"bC8","d8":"qD8","e8":"kE8","f8":"bF8","g8":"nG8","h8":"rH8"
}

# dizCaseCattura ---> chiave=nome_casa:valore=tuplaCoordinateCasa
# dizionario delle coordinate delle 15 case dei pezzi catturati
var dizCaseCattura={
"PA2":CtN1,"PB2":CtN2, "PC2":CtN3, "PD2":CtN4, "PE2" :CtN5,"PF2" :CtN6,"PG2":CtN7,"PH2":CtN8,
"RA1":CtN9,"RH1":CtN10,"NB1":CtN11,"NG1":CtN12,"BC1":CtN13,"BF1":CtN14,"QD1":CtN15,
"pA7":CtB1,"pB7":CtB2, "pC7":CtB3, "pD7":CtB4, "pE7" :CtB5,"pF7" :CtB6,"pG7":CtB7,"pH7":CtB8,
"rA8":CtB9,"rH8":CtB10,"nB8":CtB11,"nG8":CtB12,"bC8":CtB13,"bF8":CtB14,"qD8":CtB15
}

# lista dei nomi delle case per marcatura mossa
var listNomiCase=[
"a1","a2","a3","a4","a5","a6","a7","a8",
"b1","b2","b3","b4","b5","b6","b7","b8",
"c1","c2","c3","c4","c5","c6","c7","c8",
"d1","d2","d3","d4","d5","d6","d7","d8",
"e1","e2","e3","e4","e5","e6","e7","e8",
"f1","f2","f3","f4","f5","f6","f7","f8",
"g1","g2","g3","g4","g5","g6","g7","g8",
"h1","h2","h3","h4","h5","h6","h7","h8"
]

# listCaseCatturaNeriPromossi ---> coordinate delle case dei pezzi promossi catturati Neri
var listCaseCatturaNeriPromossi    = [CttN0,CttN1,CttN2,CttN3,CttN4,CttN5,CttN6,CttN7]
# listCaseCatturaNeriPromossi ---> coordinate delle case dei pezzi promossi catturati bianchi
var listCaseCatturaBianchiPromossi    = [CttB0,CttB1,CttB2,CttB3,CttB4,CttB5,CttB6,CttB7]

# dizNomiPromossi ---> chiave=tipo pezzo (QqRrBbNn):valore=nome pezzo promosso + 0/7
var dizNomiPromossi={
'Q': 'Qtt', 'R': 'Rtt', 'B': 'Btt', 'N': 'Ntt',
'q': 'qtt', 'r': 'rtt', 'b': 'btt', 'n': 'ntt'
}

var mossa_corrente=0
var textMossa  = "" # testo della mossa corrente per la scena HUD
var sp10="          "
var sp20=sp10+sp10
#### testo di avviso inizio e istruzioni per la scena HUD
var textAvviso = sp20+"Inizio partita...\n"+sp10+"'A'=Avanti, 'Z'= Indietro\nCursori = vista | Spazio = Audio On/Off"

var pezziCatturati=0 # numero dei pezzi catturati. Mi serve come indice
                     # per il dizPezziCattura nella procedura "indietro"
var  os
var originalPath
var currentHash
#########################################################################################
##########################    FINE INIZIALIZZAZIONE    ##################################
#########################################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

# Called when the node enters the scene tree for the first time.
func _ready():
    suona($Audio_start)
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
            # r=dir.copy("res://temp/pgn-extract.exe","user://temp/pgn-extract.exe")
            r=dir.copy("res://temp/pgn_win.bat","user://temp/pgn_win.bat")
        else:
            print("sistema operativo non supportato. Premi F8 per uscire...")
#    currentHash=leggoHash("user://temp/current.pgn")
#    print("233 ---> currentHash= ",currentHash)
    textAvviso="----->                    Inizio partita...                      <-----"
    scriviHUD(textAvviso)
    scriviHelp("F1 = help ON/OFF   ---   Tasti A e Z mosse Avanti/Indietro")
    initCase() # imposta le coordinate di ogni casa nel dizionario dizScacchiera

    inizializza()

    my_vars()
    read_listamosse()
    read_list_mosse()
    make_listEnPassant()
    $EmptyControlloCamera.set_scale(Vector3(1,0.55,0.55))


func initCase():
    A1=$a1.get_translation()
    A2=$a2.get_translation()
    A3=$a3.get_translation()
    A4=$a4.get_translation()
    A5=$a5.get_translation()
    A6=$a6.get_translation()
    A7=$a7.get_translation()
    A8=$a8.get_translation()

    B1=$b1.get_translation()
    B2=$b2.get_translation()
    B3=$b3.get_translation()
    B4=$b4.get_translation()
    B5=$b5.get_translation()
    B6=$b6.get_translation()
    B7=$b7.get_translation()
    B8=$b8.get_translation()

    C1=$c1.get_translation()
    C2=$c2.get_translation()
    C3=$c3.get_translation()
    C4=$c4.get_translation()
    C5=$c5.get_translation()
    C6=$c6.get_translation()
    C7=$c7.get_translation()
    C8=$c8.get_translation()

    D1=$d1.get_translation()
    D2=$d2.get_translation()
    D3=$d3.get_translation()
    D4=$d4.get_translation()
    D5=$d5.get_translation()
    D6=$d6.get_translation()
    D7=$d7.get_translation()
    D8=$d8.get_translation()

    E1=$e1.get_translation()
    E2=$e2.get_translation()
    E3=$e3.get_translation()
    E4=$e4.get_translation()
    E5=$e5.get_translation()
    E6=$e6.get_translation()
    E7=$e7.get_translation()
    E8=$e8.get_translation()

    F1=$f1.get_translation()
    F2=$f2.get_translation()
    F3=$f3.get_translation()
    F4=$f4.get_translation()
    F5=$f5.get_translation()
    F6=$f6.get_translation()
    F7=$f7.get_translation()
    F8=$f8.get_translation()

    G1=$g1.get_translation()
    G2=$g2.get_translation()
    G3=$g3.get_translation()
    G4=$g4.get_translation()
    G5=$g5.get_translation()
    G6=$g6.get_translation()
    G7=$g7.get_translation()
    G8=$g8.get_translation()

    H1=$h1.get_translation()
    H2=$h2.get_translation()
    H3=$h3.get_translation()
    H4=$h4.get_translation()
    H5=$h5.get_translation()
    H6=$h6.get_translation()
    H7=$h7.get_translation()
    H8=$h8.get_translation()

    dizScacchiera = {
    "a1":A1,"a2":A2,"a3":A3,"a4":A4,"a5":A5,"a6":A6,"a7":A7,"a8":A8,
    "b1":B1,"b2":B2,"b3":B3,"b4":B4,"b5":B5,"b6":B6,"b7":B7,"b8":B8,
    "c1":C1,"c2":C2,"c3":C3,"c4":C4,"c5":C5,"c6":C6,"c7":C7,"c8":C8,
    "d1":D1,"d2":D2,"d3":D3,"d4":D4,"d5":D5,"d6":D6,"d7":D7,"d8":D8,
    "e1":E1,"e2":E2,"e3":E3,"e4":E4,"e5":E5,"e6":E6,"e7":E7,"e8":E8,
    "f1":F1,"f2":F2,"f3":F3,"f4":F4,"f5":F5,"f6":F6,"f7":F7,"f8":F8,
    "g1":G1,"g2":G2,"g3":G3,"g4":G4,"g5":G5,"g6":G6,"g7":G7,"g8":G8,
    "h1":H1,"h2":H2,"h3":H3,"h4":H4,"h5":H5,"h6":H6,"h7":H7,"h8":H8,
    "crp":zz
    }


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


func my_vars():
    var f='user://temp/varsGodot'
    var vars=read_vars(f)
    nmosse   = int(vars[0])
    White    = vars[1]
    Black    = vars[2]
    Result   = vars[3]
    var txt=("Bianco = "+White+" --- Nero = "+Black+" --- Risultato = "+Result+" --- Numero di mosse = "+str(nmosse/2))
    scriviPlayers(txt)


func read_listamosse():
    var f='user://temp/listamosse'
    for i in nmosse:
        var ind=i*2
        var lista=read_vars(f)
        var m1 = lista[ind]
        var m2 = lista[ind+1]
        var mossa=[]
        mossa.push_back(m1)
        mossa.push_back(m2)
        i=i+1
        if i:
            listamosse.push_back(mossa)


func read_list_mosse():
    var f='user://temp/list_mosse'
    var lista=read_vars(f)
    for i in nmosse:
        var mossa=lista[i]
        list_mosse.push_back(mossa)


func make_listEnPassant():
    for i in nmosse:
        listEnPassant.push_back(0)


func _input(ev):
    # rotazione della camera con i tasti cursore
    var rotazione = $EmptyControlloCamera.get_rotation()
    var rx = (rad2deg(rotazione[0]))
    var ry = (rad2deg(rotazione[1]))
    var rz = (rad2deg(rotazione[2]))
    # zoom avanti e indietro con i tasti + e -
    var zoom = $EmptyControlloCamera.get_scale()
    var sx = (zoom[0])
    var sy = (zoom[1])
    var sz = (zoom[2])
    var zm = 0.0125

    if ev is InputEventKey:
        if ev.pressed and ev.scancode  == KEY_UP: # ruota la vista im alto
            if rx > -40:
                rx = rx-1
            $EmptyControlloCamera.set_rotation_degrees(Vector3(rx,ry,rz))
            #print ("UP")
        if ev.pressed and ev.scancode == KEY_DOWN: # ruota la vista im basso
            if rx < 10:
                rx = rx+1
            $EmptyControlloCamera.set_rotation_degrees(Vector3(rx,ry,rz))
            #print ("DOWN")
        if ev.pressed and ev.scancode == KEY_LEFT: # ruota la vista a sinistra
            ry = ry-1
            $EmptyControlloCamera.set_rotation_degrees(Vector3(rx,ry,rz))
        if ev.pressed and ev.scancode == KEY_RIGHT: ## ruota la vista a destra
            ry = ry+1
            $EmptyControlloCamera.set_rotation_degrees(Vector3(rx,ry,rz))
        if ev.pressed and ev.scancode  == KEY_KP_SUBTRACT: # zoom indietro
            if sy < 2:
                sy = sy + zm
                sz = sz + zm
            $EmptyControlloCamera.set_scale(Vector3(sx,sy,sz))
        if ev.pressed and ev.scancode  == KEY_KP_ADD: # zoom avanti
            if sy > 0.4:
                sy = sy - zm
                sz = sz - zm
            $EmptyControlloCamera.set_scale(Vector3(sx,sy,sz))

        if ev.pressed and ev.scancode == KEY_A:
            avanti()

        if ev.pressed and ev.scancode == KEY_Z:
            indietro()
#
        if ev.pressed and ev.scancode == KEY_SPACE: # resetta zoom e rotazione della camera
            $EmptyControlloCamera.set_scale(Vector3(1,0.55,0.55))
            $EmptyControlloCamera.set_rotation_degrees(Vector3(2,0,0))

        if ev.pressed and ev.scancode == KEY_F12: #   FA RIPARTIRE LA SCENA DALL'INIZIO
#            var h=leggoHash("user://temp/current.pgn")
#            print("439 ---> Ora hash è:  ",h)
#            if h==currentHash:
#                pass
#            else:  
#                noAnnotations()
#                leggo_uci()
#                scriviFileVars()
#                leggo_pgn()
                var tree_node: SceneTree = get_tree()
                tree_node.reload_current_scene()

        if ev.pressed and ev.scancode == KEY_F3:
            if audio==1:
                audio=0
                textAudio = "Audio OFF"
            else:
                audio=1
                textAudio = "Audio ON"

        if ev.pressed and ev.scancode == KEY_F10: # window (1024*600 centered) / full screen
            var x=(OS.get_screen_size()[0]-1024)/2
            var y=(OS.get_screen_size()[1]-600)/2
            if OS.get_window_size()[0]==1024:
                var s=OS.get_screen_size()
                #var s = Vector2(1920, 800)
                var p = Vector2(0, 0)
                OS.set_window_size(s)
                OS.set_window_position(p)
            else:
                var s = Vector2(1024, 600)
                var p = Vector2(x, y)
                OS.set_window_size(s)
                OS.set_window_position(p)


##########################################################################
##################   inizio codice AVANTI  (tasto a)  ####################
##########################################################################

func avanti():
    if (int(num_mss) < int(nmosse)):
        num_mss    = num_mss +1
        var mossa = listamosse[mossa_corrente] # <--------- questo dovrebbe funzionare
        var casa_da=mossa[0] # queste istruzioni mi danno il valore che mi aspetto solo se
        var casa_a =mossa[1] # inserisco le linee da 414 a 417 e commento le linee 412 e 413
        avanti=1
        indietro=0
        var promozione=0
        var flagCattura=0
        var scacco=0
        var matto=0
        var m=list_mosse[mossa_corrente]

        if "+" in m:
            m= m.left(len(m)-1)
            #m = m.strip("+")
            scacco=1

        if "#" in m:
            m = m.left(len(m)-1)
            matto=1

        if "=" in m:
            promozione=1

        if m == "O-O" :
            arrocco=1

        if m == "O-O-O" :
            arrocco=2

        var resto=mossa_corrente % 2 # vedo chi ha mosso: se resto=0 ha mosso il bianco
        var nomePezzo=dizPosizione[str(casa_da)]  # ricavo il nome del pezzo in "casa_da"
        #  controllo se la mossa cattura un pezzo
        if "x" in list_mosse[mossa_corrente]: # se la mossa prevede una presa
            A_cattura(casa_a,nomePezzo,resto) 		   # eseguo la procedura
            flagCattura=1

        if promozione:
            var casa=casa_a.left(len(casa_a)-1)
            pezzoPromosso=casa_a.right(2)
            casa_a=casa
            var casaPromozione = dizScacchiera[str(casa_a)]
            if flagCattura:
                pezzoPromosso=A_soloNomePezzoPromosso(pezzoPromosso,resto)
            else:
                pezzoPromosso=A_nomePezzoPromosso(pezzoPromosso,resto)
            dizPosizione[str(casa)]  = promossoConPresa
            if nomePezzo.left(1) == "P":   # se il pedone promosso è Bianco (P maiuscola)
                listPedoniBianchiPromossi.append(nomePezzo)
            elif nomePezzo.left(1) == "p": # se il pedone promosso è Nero (p minuscola)
                listPedoniNeriPromossi.append(nomePezzo)
        var da = dizScacchiera[str(casa_da)]		# tuple delle coordinate (x,y,z)
        var a  = dizScacchiera[str(casa_a)] 		# delle case di partenza e di arrivo
        var scritta="Semimossa n. "+str(mossa_corrente+1)+" ---> avanti: "+nomePezzo+" da "+casa_da+" a "+casa_a
        A_marcaMossa(listamosse[mossa_corrente][0],listamosse[mossa_corrente][1])
        casePrecedenti=(listamosse[mossa_corrente])
        textMossa = list_mosse[mossa_corrente]
        scritta=scritta+"   ---   Mossa = "+str(mossa)+"   ---   Mossa PGN = "+str(textMossa)
        scriviHUD(scritta)
        if len(listamosse) == mossa_corrente+1:

            if Result == "1/2-1/2":
                fine="La partita è patta!"
            elif Result == "1-0":
                if matto:
                    fine="Scacco matto!"
                else:
                    fine="Il nero abbandona..."
            elif Result == "0-1":
                if matto:
                    fine="Scacco matto!"
                else:
                    fine="Il bianco abandona..."
            elif Result == "*":
                fine="Risultato sconosciuto o partita interrotta..."

            textAvviso=fine
            scriviHUD(textAvviso)
        else:
            var textAvviso=""
        if promozione:
            get_node(nomePezzo).hide() # se il pezzo viene promosso lo nascondo
            muoviPezzo(pezzoPromosso,a) # e metto nella casa "a" il pezzo promosso
        else:
            get_node(nomePezzo).set_translation(a)  # <---- devo spostare il pezzo in "a" che contiene le coordinate x,y,z ??????? trovami
        if not arrocco:
            if cattura:
                suona($Audio_presa)
                cattura=0
            else:
                suona($Audio_move)

        if resto == 0:
            if arrocco == 1: # arrocco corto del bianco
                A_arroccoTorre("RH1","f1","h1")
            if arrocco == 2: # arrocco lungo del bianco
                A_arroccoTorre("RA1","d1","a1")
        else:
            if arrocco == 1: # arrocco corto del nero
                A_arroccoTorre("rH8","f8","h8")
            if arrocco == 2:# arrocco lungo del nero
                A_arroccoTorre("rA8","d8","a8")

        if scacco:
            suona($Audio_check)     #print("Scacco!")
        if matto:
            suona($Audio_matto)
            var textAvviso="Scacco matto!"
        mossa_corrente = mossa_corrente+1  # incremento il numero della mossa
        # aggiorno il dizionario della posizione dei pezzi sulla scacchiera
        dizPosizione[str(casa_da)] = ''
        if promozione:
            if promossoConPresa == "xxxx":
                dizPosizione[str(casa_a)]  = pezzoPromosso
            else:
                dizPosizione[str(casa_a)]  = promossoConPresa
        else:
            dizPosizione[str(casa_a)]  = nomePezzo
    else:
        if nomossa == 0:
            suona($Audio_end)
            var textAvviso="----->                  La partita è finita!                     <-----"
            scriviHUD(textAvviso)
            nomossa = 1

#########################################################################################
#####################     Inizio funzioni Avanti  func A_....    ########################
#########################################################################################

func A_nomePezzoPromossoConCattura(pezzoPromosso,pezzoCatturato,resto):
    var indice=0
    if pezzoPromosso == "q" or  pezzoPromosso == "Q": # regina
        if resto:
            indice=len(listRegineNerePromosse)
            listRegineNerePromosse.push_back("qtt"+str(indice))
            pezzoPromosso=(listRegineNerePromosse[indice-1])
        else:
            indice=len(listRegineBianchePromosse)
            listRegineBianchePromosse.push_back("Qtt"+str(indice))
            pezzoPromosso=(listRegineBianchePromosse[indice-1])
    elif pezzoPromosso == "r" or pezzoPromosso == "R": # torre
        if resto:
            indice=len(listTorriNerePromosse)
            listTorriNerePromosse.push_back("rtt"+str(indice))
            pezzoPromosso=(listTorriNerePromosse[indice-1])
        else:
            indice=len(listTorriBianchePromosse)
            listTorriBianchePromosse.push_back("Rtt"+str(indice))
            pezzoPromosso=(listTorriBianchePromosse[indice-1])
    elif pezzoPromosso == "b" or pezzoPromosso == "B": # alfiere
        if resto:
            indice=len(listAlfieriNeriPromossi)
            listAlfieriNeriPromossi.push_back("btt"+str(indice))
            pezzoPromosso=(listAlfieriNeriPromossi[indice-1])
        else:
            indice=len(listAlfieriBianchiPromossi)
            listTorriBianchePromosse.push_back("Btt"+str(indice))
            pezzoPromosso=(listTorriBianchePromosse[indice-1])
    elif pezzoPromosso == "n" or pezzoPromosso == "N": # cavallo
        if resto:
            indice=len(listCavalliNeriPromossi)
            listCavalliNeriPromossi.push_back("ntt"+str(indice))
            pezzoPromosso=(listCavalliNeriPromossi[indice-1])
        else:
            indice=len(listCavalliBianchiPromossi)
            listCavalliBianchiPromossi.push_back("Ntt"+str(indice))
            pezzoPromosso=(listCavalliBianchiPromossi[indice-1])
    return pezzoPromosso


func A_nomePezzoPromosso(pezzoPromosso,resto):    #
    var indice=0
    if pezzoPromosso == "q" or pezzoPromosso == "Q": # regina
        if resto:
            indice=len(listRegineNerePromosse)
            listRegineNerePromosse.push_back("qtt"+str(indice))
            pezzoPromosso=(listRegineNerePromosse[indice])
        else:
            indice=len(listRegineBianchePromosse)
            listRegineBianchePromosse.push_back("Qtt"+str(indice))
            pezzoPromosso=(listRegineBianchePromosse[indice])
    elif pezzoPromosso == "r" or pezzoPromosso == "R": # torre
        if resto:
            indice=len(listTorriNerePromosse)
            listTorriNerePromosse.push_back("rtt"+str(indice))
            pezzoPromosso=(listTorriNerePromosse[indice])
        else:
            indice=len(listTorriBianchePromosse)
            listTorriBianchePromosse.push_back("Rtt"+str(indice))
            pezzoPromosso=(listTorriBianchePromosse[indice])
    elif pezzoPromosso == "b" or pezzoPromosso == "B": # alfiere
        if resto:
            indice=len(listAlfieriNeriPromossi)
            listAlfieriNeriPromossi.push_back("btt"+str(indice))
            pezzoPromosso=(listAlfieriNeriPromossi[indice])
        else:
            indice=len(listAlfieriBianchiPromossi)
            listAlfieriBianchiPromossi.push_back("Btt"+str(indice))
            pezzoPromosso=(listAlfieriBianchiPromossi[indice])
    elif pezzoPromosso == "n" or pezzoPromosso == "N": # cavallo
        if resto:
            indice=len(listCavalliNeriPromossi)
            listCavalliNeriPromossi.push_back("ntt"+str(indice))
            pezzoPromosso=(listCavalliNeriPromossi[indice])
        else:
            indice=len(listCavalliBianchiPromossi)
            listCavalliBianchiPromossi.push_back("Ntt"+str(indice))
            pezzoPromosso=(listCavalliBianchiPromossi[indice])
    return pezzoPromosso


func A_soloNomePezzoPromosso(pezzoPromosso,resto):
    var indice=0
    if pezzoPromosso == "q" or pezzoPromosso == "Q": # regina
        if resto:
            indice=len(listRegineNerePromosse)
            pezzoPromosso=(listRegineNerePromosse[indice-1])
        else:
            indice=len(listRegineBianchePromosse)
            pezzoPromosso=(listRegineBianchePromosse[indice-1])
    elif pezzoPromosso == "r" or pezzoPromosso == "R": # torre
        if resto:
            indice=len(listTorriNerePromosse)
            pezzoPromosso=(listTorriNerePromosse[indice-1])
        else:
            indice=len(listTorriBianchePromosse)
            pezzoPromosso=(listTorriBianchePromosse[indice-1])
    elif pezzoPromosso == "b" or pezzoPromosso == "B": # alfiere
        if resto:
            indice=len(listAlfieriNeriPromossi)
            pezzoPromosso=(listAlfieriNeriPromossi[indice-1])
        else:
            indice=len(listAlfieriBianchiPromossi)
            pezzoPromosso=(listAlfieriBianchiPromossi[indice-1])
    elif pezzoPromosso == "n" or pezzoPromosso == "N": # cavallo
        if resto:
            indice=len(listCavalliNeriPromossi)
            pezzoPromosso=(listCavalliNeriPromossi[indice-1])
        else:
            indice=len(listCavalliBianchiPromossi)
            pezzoPromosso=(listCavalliBianchiPromossi[indice-1])
    return pezzoPromosso


func A_cattura(casa,nomePezzo,resto):
    cattura=1
    if len(casa) == 3  and (nomePezzo.begins_with("P") or nomePezzo.begins_with("p")): # cattura con promozione
        var cc=casa.left(len(casa)-1)  # cc=casa.left(len(casa)-1)
        pezzoPromosso=casa.right(2)
        pezzoPromosso=A_nomePezzoPromossoConCattura(pezzoPromosso,nomePezzo,resto)
        casa=cc
        pezzoCatturato = dizPosizione[casa]  	  # ricavo il nome del pezzo catturato
        if resto:
            dizNomiPromossiCatturaNeri[pezzoPromosso] = pezzoCatturato
        else:
            dizNomiPromossiCatturaBianchi[pezzoPromosso] = pezzoCatturato
    else:
        pezzoCatturato = dizPosizione[casa]  	  # ricavo il nome del pezzo catturato
    if pezzoCatturato == null or pezzoCatturato == "": #cattura en passant
        enPassant=1
        listEnPassant[int(num_mss-1)]=1
        CasaPrecedente=casaEnpass(resto,casa)
        casa=CasaPrecedente
        pezzoCatturato = dizPosizione[casa]
    if resto:
        dizNomiPromossiCatturaNeri[pezzoPromosso] = pezzoCatturato
    else:
        dizNomiPromossiCatturaBianchi[pezzoPromosso] = pezzoCatturato
    var obj=get_node(pezzoCatturato)
    if "tt" in pezzoCatturato: # è un pezzo promosso e lo devo mettere nella giusta posizione
        if resto: # se resto è zero, la mossa è del bianco e il pezzo catturato (promosso) è nero
            posizione=listCaseCatturaNeriPromossi[len(dizPromossiCatturaBianchi)]
            dizPromossiCatturaBianchi[len(dizPromossiCatturaBianchi)]=pezzoCatturato
        else: # altrimenti il pezzo catturato (promosso) è nero
            posizione=listCaseCatturaBianchiPromossi[len(dizPromossiCatturaNeri)]
            dizPromossiCatturaNeri[len(dizPromossiCatturaNeri)]=pezzoCatturato
        muoviPezzo(pezzoCatturato,posizione)
    else:
        posizione=dizCaseCattura[pezzoCatturato]  # ricavo la posizione dove metterò il pezzo catturato
        muoviPezzo(pezzoCatturato,posizione)
    if enPassant:
        dizPosizione[casa] = ""   # aggiorno il dizionario della posizione sulla scacchiera
    else:
        dizPosizione[casa] = nomePezzo # aggiorno il dizionario della posizione sulla scacchiera
    dizPezziCattura[pezziCatturati] = pezzoCatturato
    pezziCatturati += 1


func A_arroccoTorre(torre,casaArrocco,casaOrigine):
    var da = dizScacchiera[casaOrigine]  	   # tuple delle coordinate (x,y,z)
    var a  = dizScacchiera[casaArrocco]  	   # delle case di partenza e di arrivo
    muoviPezzo(torre,a)
    suona($Audio_arrocco)
    arrocco=0
    dizPosizione[casaOrigine] = '' # aggiorno il dizionario della posizione
    dizPosizione[casaArrocco] = torre


func A_marcaMossa(da,a):
    da=da.left(2)
    a = a.left(2)
    if  mossa_corrente > 0:
        var cp0 = casePrecedenti[0]
        var cp1 = casePrecedenti[1]
        cp0= cp0.left(2)
        cp1= cp1.left(2)
        get_node(cp0+"s").hide()
        get_node(cp1+"s").hide()
        get_node(cp0).show()
        get_node(cp1).show()
    var obj_da = da
    var obj_a  = a
    get_node(obj_da).hide()
    get_node(obj_a).hide()       ## nascondo le case normali
    var obj_daSel = da+"s"
    var obj_aSel  = a+"s"
    get_node(obj_daSel).show()
    get_node(obj_aSel).show()    ## e visualizzo le case che marcano la mossa
    pass



##########################################################################
###################   inizio codice indietro  (z) ########################
##########################################################################

func indietro():
    var promozioneConCattura=0
    var promozione=0
    # var arrocco=0
    var scacco=0
    var matto=0
    var nomePezzo
    var resto
    var mossa
    if mossa_corrente > 0:
        resto=mossa_corrente % 2 # vedo chi ha mosso: se resto=0 ha mosso il bianco
        mossa_corrente = mossa_corrente - 1
        mossa=listamosse[mossa_corrente]
        var casa_da = mossa[1]
        var casa_a  = mossa[0]
        var m=list_mosse[mossa_corrente]
        if "+" in m:
            m= m.left(len(m)-1)
            scacco=1
        if "#" in m:
            m= m.left(len(m)-1)
            matto=1
        if "=" in m:
            promozione=1
            if "x" in m:
                promozioneConCattura=1
        if m == "O-O" :
          arrocco=1
        if m == "O-O-O" :
            arrocco=2
        if promozione: #    (indietro!!!)
            var casa
            casa=casa_da.left(2)
            pezzoPromosso=casa_da.right(len(casa_da)-1)
            pezzoCatturato=dizPosizione[casa]
            casa_da=casa
            var casaPromozione = dizScacchiera[str(casa_da)]
            resto=mossa_corrente % 2 # vedo chi ha mosso: se resto=0 ha mosso il bianco
            if promozioneConCattura: # se promozioneConCattura chiamo la procedura adatta
                pezzoCatturato=dizPezziCattura[len(dizPezziCattura)-1]  ######################  line aggiunta################################
                pezzoPromosso=I_nomePezzoPromossoConCattura(pezzoPromosso,pezzoCatturato,resto,casa)
            else:
                pezzoPromosso=I_nomePezzoPromosso(pezzoPromosso,resto)
            if resto: # promozione di un pedone nero
                nomePezzo = listPedoniNeriPromossi[len(listPedoniNeriPromossi)-1]
                listPedoniNeriPromossi.erase(nomePezzo)
                get_node(nomePezzo).show()  ######         devo rendere visibile il "nomePezzo"
            else:
                nomePezzo = listPedoniBianchiPromossi[len(listPedoniBianchiPromossi)-1]
                listPedoniBianchiPromossi.erase(nomePezzo)
                get_node(nomePezzo).show()  ######         devo rendere visibile il "nomePezzo"
            dizPosizione[casa_a]=nomePezzo
            nomePezzo = pezzoPromosso
            casa_a = "crp" # casa ripristino pezzi promossi dopo indietro
        else:
            var c1=list_mosse[mossa_corrente]
            var c2=c1.right(len(c1)-3)
            var c3=c1.right(len(c1)-3)
            c3=c3.right(len(c3)-1)     #   matto="#", scacco="+" o presa="x"
            var casa  #    devo togliere il primo carattere e non l'ultimo!  ????
            if "x" in list_mosse[mossa_corrente]:   # se la mossa prevede una presa
                casa=c2.left(len(c2)-1)
            if len(c1) > 2 and (c3 == "#" or c3 == "+"):  # torno indietro da uno scacco  ?????
                casa=c2.left(len(c2)-1)
            if (len(c2) == 3 and c3 == "x") or ("x" in c1): # torno indietro dopo una presa
                if c2.begins_with("x"):
                    casa=c2.right(1)
                else:
                    casa=c2.left(2)
                nomePezzo = dizPosizione[casa]
                I_cattura(casa_a,nomePezzo,casa_da,resto)     # eseguo la procedura
            else:
                nomePezzo = dizPosizione[str(casa_da)]  # ricavo il nome del pezzo in "casa_da"
        var da = dizScacchiera[str(casa_da)]  # tuple delle coordinate (x,y,z)
        var a  = dizScacchiera[str(casa_a)]  # delle case di ARRIVO e di PARTENZA
        var scritta="Semimossa n. "+str(mossa_corrente+1)+" <---- indietro: "+str(nomePezzo)+" da "+str(casa_da)+" a " + str(casa_a)
        textMossa = list_mosse [mossa_corrente] # textMossa = list_mosse [int(mossa/2)]
        textAvviso=""
        textAvviso=textAvviso
        I_marcaMossa(listamosse[mossa_corrente][0],listamosse[mossa_corrente][1])
        casePrecedenti=listamosse[mossa_corrente-1]
        scritta=scritta+"   ---   Mossa = "+str(mossa)+"   ---   Mossa PGN = "+str(textMossa)
        scriviHUD(scritta)
        if mossa_corrente < 1:
            textMossa=""
            textAvviso="----->                    Inizio partita...                      <-----"
            scriviHUD(textAvviso)
        I_spostaPezzo(nomePezzo,casa_a)  #pezzo.position=a        # muovo il pezzo
        resto=mossa_corrente % 2 # vedo chi ha mosso: se resto=0 ha mosso il bianco
        if resto == 0:
            if arrocco == 1: # arrocco corto del bianco
                I_arroccoTorre("RH1","f1","h1")
            if arrocco == 2: # arrocco lungo del bianco
                I_arroccoTorre("RA1","d1","a1")
        else:
            if arrocco == 1: # arrocco corto del nero
                I_arroccoTorre("rH8","f8","h8")
            if arrocco == 2: # arrocco lungo del nero
                I_arroccoTorre("rA8","d8","a8")
        if not "x" in list_mosse[mossa_corrente]:
            dizPosizione[str(casa_da)] = ''
            dizPosizione[str(casa_a)]  = nomePezzo
        if  nomossa == 1:
            nomossa =  0
        avanti=0
        indietro=1
        num_mss=num_mss-1
    else:
        if nomossa == 0:
            suona($Audio_end)
            mossa_corrente = 0
            mossa = listamosse[0]
            var cp0 = mossa[0]
            var cp1 = mossa[1]
            cp0=cp0.left(2)+"s"
            cp1=cp1.left(2)+"s"
            get_node(cp0).hide()
            get_node(cp1).hide()
            get_node(mossa[0]).show()
            get_node(mossa[1]).show()
        nomossa=1
        avanti=1
        indietro=0
        num_mss=0


#########################################################################################
#####################     Inizio funzioni indietro  func I_....    ######################
#########################################################################################

func I_marcaMossa(da,a):
    a=a.left(2)
    if mossa_corrente+1 == nmosse:
        return
    casePrecedenti = listamosse[mossa_corrente+1]
    if avanti and (mossa_corrente+1 == mossa):
        return
    else:
        if  mossa_corrente >= 0 :
            var cp0 = casePrecedenti[0]
            var cp1 = casePrecedenti[1]
            cp0=cp0.left(2)
            cp1=cp1.left(2)
            get_node(cp0+"s").hide()
            get_node(cp1+"s").hide()
            get_node(cp0).show()
            get_node(cp1).show()
        var obj_da = da
        var obj_a  = a
        get_node(obj_da).hide()
        get_node(obj_a).hide()    ## nascondo le case normali
        var obj_daSel = da+"s"
        var obj_aSel  = a+"s"
        get_node(obj_daSel).show()
        get_node(obj_aSel).show() ## e visualizzo le case che marcano la mossa


func I_spostaPezzo(nomePezzo,casa_a):
    muoviPezzo(nomePezzo,dizScacchiera[str(casa_a)])  # e metto nella casa il pezzo promosso
    if not arrocco:
        if cattura:
            suona($Audio_presa)
            cattura=0
        else:
            if not arrocco:
                suona($Audio_move)
    else:
        suona($Audio_arrocco)


func I_nomePezzoPromossoConCattura(pezzoPromosso,pezzoCatturato,resto,casa):
    var indice=0
    if pezzoPromosso == "q" or pezzoPromosso == "Q": # regina
        if resto:
            indice=len(listRegineNerePromosse)-1
            var ppr ="qtt"+str(indice)
            pezzoPromosso=(listRegineNerePromosse[indice])
            listRegineNerePromosse.erase(pezzoPromosso) # rimuova la regina promossa dal dizionario
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
        else:
            indice=len(listRegineBianchePromosse)-1
            var ppr ="Qtt"+str(indice)
            pezzoPromosso=(listRegineBianchePromosse[indice])

            listRegineBianchePromosse.erase(pezzoPromosso) # rimuova la regina promossa dal dizionario
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
    elif pezzoPromosso == "r" or pezzoPromosso == "R": # torre
        if resto:
            indice=len(listTorriNerePromosse)-1
            var ppr ="rtt"+str(indice)
            pezzoPromosso=(listTorriNerePromosse[indice])
            listTorriNerePromosse.erase(pezzoPromosso)
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
        else:
            indice=len(listTorriBianchePromosse)-1
            var ppr ="Rtt"+str(indice)
            pezzoPromosso=(listTorriBianchePromosse[indice])
            listTorriBianchePromosse.erase(pezzoPromosso) # rimuova la regina promossa dal dizionario
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
    elif pezzoPromosso == "b" or pezzoPromosso == "B": # alfiere
        if resto:
            indice=len(listAlfieriNeriPromossi)-1
            var ppr ="btt"+str(indice)
            pezzoPromosso=(listAlfieriNeriPromossi[indice])
            listAlfieriNeriPromossi.erase(ppr)
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
        else:
            indice=len(listAlfieriBianchiPromossi)-1
            var ppr ="Btt"+str(indice)
            pezzoPromosso=(listAlfieriBianchiPromossi[indice])
            listAlfieriBianchiPromossi.erase(ppr) # rimuova la regina promossa dal dizionario
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile

    elif pezzoPromosso == "n" or pezzoPromosso == "N": # cavallo
        if resto:
            indice=len(listCavalliNeriPromossi)-1
            var ppr ="ntt"+str(indice)
            pezzoPromosso=(listCavalliNeriPromossi[indice])
            listCavalliNeriPromossi.erase(ppr)
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
        else:
            indice=len(listCavalliBianchiPromossi)-1
            var ppr ="Ntt"+str(indice)
            pezzoPromosso=(listCavalliBianchiPromossi[indice])
            listCavalliBianchiPromossi.erase(ppr) # rimuova la regina promossa dal dizionario
            I_spostaPezzo(pezzoCatturato,casa)     # rimetto il pezzoCatturato sulla scacchiera
            dizPosizione[casa]=pezzoCatturato   # e nel dizionario della posizione sulla scacchiera
            pezziCatturati-=1
            I_spostaPezzo(pezzoPromosso,"crp") # rimetto il pezzoPromosso in posizione invisibile
    return pezzoPromosso


func I_nomePezzoPromosso(pezzoPromosso,resto):
    var indice=0
    if pezzoPromosso == "q" or pezzoPromosso == "Q": # regina
        if resto:
            indice=len(listRegineNerePromosse)
            var ppr ="qtt"+str(indice-1)
            pezzoPromosso=(listRegineNerePromosse[indice-1])
            listRegineNerePromosse.erase(ppr)
        else:
            indice=len(listRegineBianchePromosse) ; #print ("<--- 15 indice",indice)
            var ppr ="Qtt"+str(indice-1)
            pezzoPromosso=(listRegineBianchePromosse[indice-1])
            listRegineBianchePromosse.erase(ppr)
    elif pezzoPromosso == "r" or pezzoPromosso == "R": # torre
        if resto:
            indice=len(listTorriNerePromosse)
            var ppr ="rtt"+str(indice-1)
            pezzoPromosso=(listTorriNerePromosse[indice-1])
            listTorriNerePromosse.erase(ppr)
        else:
            indice=len(listTorriBianchePromosse) ; #print ("<--- 156 indice",indice)
            var ppr ="Rtt"+str(indice-1)
            pezzoPromosso=(listTorriBianchePromosse[indice-1])
            listTorriBianchePromosse.erase(ppr)
    elif pezzoPromosso == "b" or pezzoPromosso == "B": # alfiere
        if resto:
            indice=len(listAlfieriNeriPromossi)
            var ppr ="btt"+str(indice-1)
            pezzoPromosso=(listAlfieriNeriPromossi[indice-1])
            listAlfieriNeriPromossi.erase(ppr)
        else:
            indice=len(listAlfieriBianchiPromossi) ; #print ("<--- 171 indice",indice)
            var ppr ="Btt"+str(indice-1)
            pezzoPromosso=(listAlfieriBianchiPromossi[indice-1])
            listAlfieriBianchiPromossi.erase(ppr)
    elif pezzoPromosso == "n" or pezzoPromosso == "N": # cavallo
        if resto:
            indice=len(listCavalliNeriPromossi)
            var ppr ="ntt"+str(indice-1)
            pezzoPromosso=(listCavalliNeriPromossi[indice-1])
            listCavalliNeriPromossi.erase(ppr)
        else:
            indice=len(listCavalliBianchiPromossi) ; #print ("<--- 186 indice",indice)
            var ppr ="Ntt"+str(indice-1)
            pezzoPromosso=(listCavalliBianchiPromossi[indice-1])
            listCavalliBianchiPromossi.erase(ppr)
    return pezzoPromosso


func I_cattura(casa,nomePezzo,casaRipristino,resto):
    if int(listEnPassant[mossa_corrente]) > 0: # vedo se la mossa corrente è una presa en passant
        if resto:
            var c1=casaRipristino.left(1)
            var c2=int(casaRipristino.right(1))-1
            var c=c1+str(c2)
            casaRipristino=c
        else:
            var c1=casaRipristino.left(1)
            var c2=int(casaRipristino.right(1))+1
            var c=c1+str(c2)
            casaRipristino=c
    pezziCatturati -= 1
    pezzoCatturato = dizPezziCattura[pezziCatturati]  # ricavo il nome del pezzo catturato
    var r=dizPezziCattura.erase(pezziCatturati)
    posizione=dizScacchiera[casaRipristino]   # ricavo la posizione dove metterò il pezzo catturato
    muoviPezzo(pezzoCatturato,posizione)     # metto il pezzo nella posizione data dal dizCaseCattura
    dizPosizione[casa] = nomePezzo
    enPassant=listEnPassant[mossa_corrente]
    if enPassant:
        var cc=casaEnpass(resto,casaRipristino)
        dizPosizione[cc]=""
        dizPosizione[casaRipristino] = pezzoCatturato 
        dizPosizione[casa]  = nomePezzo
    else:
        dizPosizione[casa] = nomePezzo    #   dizPosizione[casa] = ""   # nomePezzo
        dizPosizione[casaRipristino] = pezzoCatturato   # aggiorno il dizionario della posizione sulla scacchiera


func I_arroccoTorre(torre,casaArrocco,casaOrigine):
    var a = dizScacchiera[casaOrigine]  	   # tuple delle coordinate (x,y,z)
    var da  = dizScacchiera[casaArrocco]  	   # delle case di partenza e di arrivo
    muoviPezzo(torre,a)
    arrocco=0
    dizPosizione[casaOrigine] = ''  #    aggiorno il dizionario della posizione
    dizPosizione[casaArrocco] = torre


func aspetta(sec):
    var t = Timer.new()
    t.set_wait_time(sec)
    t.set_one_shot(true)
    self.add_child(t)
    t.start()
    yield(t, "timeout")


func muoviPezzo(pp,cc):
    var obj=get_node(pp)
    obj.set_translation(cc) # e metto nella casa cc il pezzo


func suona(s):
    if audio:
        s.play(0)


func scriviHUD(txt):
    var nodepath="CanvasLayer/HUD/TextAvviso"
    get_node(nodepath).set_text(txt)


func scriviHelp(txt):
    var nodepath="CanvasLayer/HUD/help"
    get_node(nodepath).set_text(txt)


func scriviPlayers(txt):
    var nodepath="CanvasLayer/HUD/Players"
    get_node(nodepath).set_text(txt)


func inizializza():
    var directory = Directory.new()
    if not directory.dir_exists("user://temp"):
        directory = Directory.new( )
        directory.make_dir("user://temp")
        var dir = Directory.new()
        var r=dir.copy("res://temp/current.pgn","user://temp/current.pgn")
    # DEVO SOPPRIMERE I COMMENTI CON DAL PGN (-C -N -V)
    noAnnotations() # Crea il file current.uci e il file moves.pgn senza annotazioni
    leggo_uci()
    scriviFileVars()
    leggo_pgn()


func noAnnotations():
    var user_temp=OS.get_user_data_dir()+"/temp"
    var file_pgn=str(user_temp+"/current.pgn")
    var array =  [file_pgn]
    var args = PoolStringArray(array)
    var output = []
    if os=="Windows":
        var r=OS.execute(user_temp+'/pgn_win.bat',[], true, output)
    elif os=="X11":
        var r=OS.execute('pgn_x11.sh',args, true, output)


func leggo_uci():
    var partita=crea_array_uci()
    for i in len(partita)-1:
        var linea=partita[i]
        var pp=partita[i+1]
        if linea=="":
            mosse_uci=pp
            break
        if linea.begins_with ( '[White "'):
            White=linea.lstrip('[White "')
            White=White.left(len(White)-2)
        if linea.begins_with ( '[Black "'):
            Black=linea.lstrip('[Black "')
            Black=Black.left(len(Black)-2)
        if linea.begins_with ( '[Result "'):
            Result=linea.lstrip('[Result "')
            Result=Result.left(len(Result)-2)
    mosse_uci=mosse_uci.rsplit(" ")
    mosse_uci.remove (len(mosse_uci)-1)
    nmosse=(len(mosse_uci))
    var file = File.new()
    file.open("user://temp/listamosse", File.WRITE)
    for i in len(mosse_uci):
        var m=mosse_uci[i]
        var da= m.left(2)
        var a=  m.right(2)
        file.store_string(da+"\n")
        file.store_string(a+"\n")
    file.close()


func scriviFileVars():
    var file = File.new()
    file.open("user://temp/varsGodot", File.WRITE)
    file.store_string(str(nmosse)+"\n")
    file.store_string(White+"\n")
    file.store_string(Black+"\n")
    file.store_string(Result+"\n")
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
    mosse_pgn.remove (nmosse)
    var file = File.new()
    file.open("user://temp/list_mosse", File.WRITE)
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


func casaEnpass(resto,casa):
    if resto==0: # se la mossa è del bianco e se casa è ad es "A5" allora deve diventare "A4"
        var n=casa.right(len(casa)-1)
        var c=casa.left(len(casa)-1)
        n=int(n)-1
        CasaPrecedente=(c+str(n))
    else: # se la mossa è del nero e se casa è ad es "A5" allora deve diventare "A6"
        var n=casa.right(len(casa)-1)
        var c=casa.left(len(casa)-1)
        n=int(n)+1
        CasaPrecedente=(c+str(n))
    return CasaPrecedente
    
    
#func _notification(what):
#    if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
#        print("focus in")
#    elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
#        print("focus out")


#func leggoHash(file):
#    var f = File.new()
#    if !f.file_exists(file):
#        return
#    f.open(file, File.READ)
#    var filehash=f.get_md5("user://temp/current.pgn")
#    return filehash
#    pass
##
#func salvaPath():
#    os=OS.get_name()
#    if os=="X11":
#        pass
#    elif os=="Windows":
#        #originalPath=%path%
#        pass
#    else:        
#        print("sistema operativo non supportato. Premi F8 per uscire...")
#
#
#func ripristinaPath():
#    os=OS.get_name()
#    if os=="X11":
#        pass
#    elif os=="Windows":
#        pass
#    else:        
#        print("sistema operativo non supportato. Premi F8 per uscire...")
#
#
#func setWinPath():
#    var winPath="path C:\\PGNviewer3D\\temp;%path%"
#    var output = []
#    var r=OS.execute(winPath,[], true, output)
#    pass
    