#! /usr/bin/env bash

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

const fmtUS = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
    timeZone: 'America/New_York',
});

const date = new Date();

process.stdout.write('🇦🇷 (CBA) ' + fmtAR.format(date) + '  🇨🇱 (SGO) ' + fmtCL.format(date) + '  🇺🇸 (NY) ' + fmtUS.format(date) + ' ');
"
