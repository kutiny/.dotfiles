#! /bin/bash

node -e "
const fmtCL = new Intl.DateTimeFormat('es-AR', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
    timeZone: 'America/Santiago',
});

const fmtAR = new Intl.DateTimeFormat('es-AR', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
    timeZone: 'America/Argentina/Cordoba',
});

const date = new Date();

process.stdout.write('🇦🇷 ' + fmtAR.format(date) + '  🇨🇱 ' + fmtCL.format(date) + ' ');
"
