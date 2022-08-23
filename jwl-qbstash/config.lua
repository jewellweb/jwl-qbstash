----- DISCORD: Jew#1881 -----

Config = {}

Config.JWLDepo = {
    jwlDepo = {
        Stash = {
            vector3(-1197.93, -693.583, 40.909) -- DEPO KOORDİNAT
        },
    }
}


Config.Items = { -- SİLAH KOYACAKSANIZ TYPE YAZAN YERİ "weapon", İTEM KOYACAKSANIZ "item" OLARAK AYARLAYIN
    label = "Eşyalar",                
    slots = 30, -- EŞYA SATIN ALMA ENVANTER SLOT SAYISI
    items = {
		[1] = {
            name = "water", -- İSTEDİĞİNİZ İTEM
            amount = 1, -- BURADAN STOK AYARLAYABİLİRSİNİZ
            type = "item", -- WEAPON YADA İTEM OLACAK
            slot = 1, -- HER İTEM EKLEDİĞİNİZDE SLOT SAYISINI BİR ÖNCEKİNE GÖRE YÜKSELTMEYİ UNUTMAYIN! ÖRNEK SLOT 3 İSE ALTTAKİ KISMI 4 YAPIN.
        },
        [2] = {
            name = "weapon_bat",
            amount = 1,
            type = "weapon",
            slot = 2,
		},
	[3] = {
            name = "armor",
            amount = 1,
            type = "item",
            slot = 3,
        }
    }
}
