@{
    Year  = @{ One = '{0} an';      Other = '{0} ans' }
    Month = @{ One = '{0} mois';    Other = '{0} mois' }   # invariant plural
    Day   = @{ One = '{0} jour';    Other = '{0} jours' }
    Hour  = @{ One = '{0} heure';   Other = '{0} heures' }
    Min   = @{ One = '{0} minute';  Other = '{0} minutes' }
    Sec   = @{ One = '{0} seconde'; Other = '{0} secondes' }

    Separator      = ', '
    NegativeSign   = '-'              # or '−' (U+2212) if you prefer
    ZeroFallback   = '0 secondes'     # French normally uses plural with zero
    IncludeZerosOn = '{0} {1}'
}