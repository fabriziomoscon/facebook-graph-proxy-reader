module.exports = {


  ###
    http://youtu.be/JJd05xURxTQ
    http://www.youtube.com/watch?v=pq1s6FCEoZM
    http://youtu.be/vldh7oQD-a4
    http://youtu.be/pEjzFRHO6HM
    https://www.youtube.com/watch?v=D_7xQyvBD20
    http://youtu.be/fMHdq4jm0oQ
    http://youtu.be/APsUVyeHgH0
    http://youtu.be/ncdLNx_sqJ8
    http://www.youtube.com/watch?v=4CxYcqWE-Do
    http://youtu.be/_FGOSmpo2Jc
    http://youtu.be/10sn4h64FRo
    http://youtu.be/jjfcggmk9MU
    http://www.youtube.com/watch?v=XbGs_qK2PQA&feature=player_detailpage
    http://youtu.be/Urdlvw0SSEc
    http://www.youtube.com/watch?v=pSvyF_ZuXyc
    http://youtu.be/lcOxhH8N3Bo
    http://www.youtube.com/watch?v=xI6HV8As2zw
  ###  
  extractId: (link) ->
    m = link.match /[http:\/\/]?[www\.]?(youtube\.com\/|youtu\.be\/)(watch\?v=)?([\w-]*)/
    return m[3]

}
