
description 'VT_Leaderboard'

version '1.0.0'

author 'Made by @Storm#9999 | Styling/Frotend: @vladimirdebarie'

fx_version 'adamant'
games { 'gta5' }


server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
} 

client_script 'client/main.lua'


shared_script 'config.lua'

ui_page "ui/index.html"
    

files {
    'ui/style.css',
    'ui/js/listener.js',
    'client/html/index.html',
    'ui/img/dmg.png',
    'ui/img/global.png',
    'ui/img/gold1.png',
    'ui/img/gold2.png',
    'ui/img/gold3.png',
    'ui/img/gold4.png',
    'ui/img/le.png',
    'ui/img/le2.png',
    'ui/img/mg1.png',
    'ui/img/mg2.png',
    'ui/img/mg3.png',
    'ui/img/progres.png',
    'ui/img/silver1.png',
    'ui/img/silver2.png',
    'ui/img/silver3.png',
    'ui/img/silver4.png',
    'ui/img/silver5.png',
    'ui/img/Supreme.png',
    'ui/img/test.png',
    'ui/img/test1.png'
}
