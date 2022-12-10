# defmodule DarkKernel.DarkKeywords.WhitespaceInsensitivityTest do
#   use ExUnit.Case, async: true
#   import ExUnitProperties
#   import StreamData

#   import DarkKernel

#   # ----------------------------------------------
#   # ~k[] lists are not whitespace sensitive
#   # ----------------------------------------------

#   test "~k[] are whitespace insensitive, example #1: 2 variables" do
#     check all qaLEAzb1s6jnx <- term(),
#               hubgN <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[qaLEAzb1s6jnx, hubgN] == ~k[qaLEAzb1s6jnx, hubgN]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #2: 3 variables" do
#     check all c6ba? <- term(),
#               n1HIKznOBp_yN? <- term(),
#               okrHD_F? <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[c6ba?, n1HIKznOBp_yN?, okrHD_F?] == ~k[c6ba? ,n1HIKznOBp_yN?,okrHD_F?  ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #3: 4 variables" do
#     check all ngy_O6x_ <- term(),
#               wQbztSX_ZOLhU <- term(),
#               l_R5 <- term(),
#               jDi? <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[ngy_O6x_, wQbztSX_ZOLhU, l_R5, jDi?] == ~k[ngy_O6x_,wQbztSX_ZOLhU
# ,l_R5,jDi?
# ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #4: 5 variables" do
#     check all tv0Y! <- term(),
#               diy5w2UiM2 <- term(),
#               dy_5 <- term(),
#               y__fx0c <- term(),
#               qXs <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[tv0Y!, diy5w2UiM2, dy_5, y__fx0c, qXs] ==
#                ~k[tv0Y!,diy5w2UiM2,dy_5,y__fx0c    ,qXs ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #5: 6 variables" do
#     check all qQw! <- term(),
#               z? <- term(),
#               ifU2XtHkQ? <- term(),
#               s_wcoLXybj0JF_ <- term(),
#               lC_WG_Js_qqnmC <- term(),
#               aEy2tKEZ7nU__ <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[qQw!, z?, ifU2XtHkQ?, s_wcoLXybj0JF_, lC_WG_Js_qqnmC, aEy2tKEZ7nU__] ==
#                ~k[qQw!, z? , ifU2XtHkQ?,s_wcoLXybj0JF_,   lC_WG_Js_qqnmC,aEy2tKEZ7nU__]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #6: 7 variables" do
#     check all pE <- term(),
#               zg0 <- term(),
#               doeaml_Hx! <- term(),
#               c_f9s <- term(),
#               d9 <- term(),
#               qBS_0agKZ <- term(),
#               uld_p <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[pE, zg0, doeaml_Hx!, c_f9s, d9, qBS_0agKZ, uld_p] == ~k[pE, zg0
# , doeaml_Hx!,c_f9s,  d9,
#   qBS_0agKZ,uld_p]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #7: 8 variables" do
#     check all q_t_ <- term(),
#               lo1NQ_Sft7m_JC9_! <- term(),
#               no2TcrdAjYBC3h__? <- term(),
#               yAxAiYeSz! <- term(),
#               aZgnBiyUnJA4ZQy_ <- term(),
#               qHZw_p6xDH2rt32! <- term(),
#               jMeYJAhh <- term(),
#               y3? <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[q_t_, lo1NQ_Sft7m_JC9_!, no2TcrdAjYBC3h__?, yAxAiYeSz!, aZgnBiyUnJA4ZQy_, qHZw_p6xDH2rt32!, jMeYJAhh, y3?] ==
#                ~k[q_t_ , lo1NQ_Sft7m_JC9_! ,  no2TcrdAjYBC3h__?,yAxAiYeSz!,aZgnBiyUnJA4ZQy_  ,qHZw_p6xDH2rt32! ,jMeYJAhh,y3?     ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #8: 9 variables" do
#     check all dfHThlTxyWOyH! <- term(),
#               jM4LvA <- term(),
#               p2! <- term(),
#               mk_Mivn6jq! <- term(),
#               a_XeDlWAA <- term(),
#               qkD9e_S54xSta7? <- term(),
#               n! <- term(),
#               szsHux_E? <- term(),
#               cpJI! <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[dfHThlTxyWOyH!, jM4LvA, p2!, mk_Mivn6jq!, a_XeDlWAA, qkD9e_S54xSta7?, n!, szsHux_E?, cpJI!] ==
#                ~k[dfHThlTxyWOyH!
# ,
# jM4LvA,p2!   ,mk_Mivn6jq!,    a_XeDlWAA,qkD9e_S54xSta7?  ,n!
# ,


# szsHux_E? ,cpJI!]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #9: 10 variables" do
#     check all e_! <- term(),
#               vFmSD__X! <- term(),
#               c4_Sr_eE_nK? <- term(),
#               hU <- term(),
#               uxDmTShmGTOpWP3q <- term(),
#               jaE_xfR3e! <- term(),
#               g4NUK_GK_YFK! <- term(),
#               jrqrpw_dvqbqC_ <- term(),
#               gg? <- term(),
#               z0EakQ <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[e_!, vFmSD__X!, c4_Sr_eE_nK?, hU, uxDmTShmGTOpWP3q, jaE_xfR3e!, g4NUK_GK_YFK!, jrqrpw_dvqbqC_, gg?, z0EakQ] ==
#                ~k[e_! , vFmSD__X!,c4_Sr_eE_nK?
#  ,hU ,   uxDmTShmGTOpWP3q,
# jaE_xfR3e!  ,
#     g4NUK_GK_YFK!,jrqrpw_dvqbqC_,gg?,
# z0EakQ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #10: 11 variables" do
#     check all fPsKc_QkEUR2c! <- term(),
#               p4Y! <- term(),
#               o6uV! <- term(),
#               yapBk7_t5mDB__! <- term(),
#               aZ_VOZmZ <- term(),
#               sKRChp6NQYmY <- term(),
#               lw! <- term(),
#               yLf_jRCPT <- term(),
#               wjqkjX_9XK_YK <- term(),
#               e <- term(),
#               ahYgrQ_uh <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[fPsKc_QkEUR2c!, p4Y!, o6uV!, yapBk7_t5mDB__!, aZ_VOZmZ, sKRChp6NQYmY, lw!, yLf_jRCPT, wjqkjX_9XK_YK, e, ahYgrQ_uh] ==
#                ~k[fPsKc_QkEUR2c! ,p4Y!, o6uV!,yapBk7_t5mDB__!,aZ_VOZmZ,sKRChp6NQYmY   ,
# lw!
#    ,
# yLf_jRCPT,   wjqkjX_9XK_YK,    e,    ahYgrQ_uh    ]
#     end
#   end

#   test "~k[] are whitespace insensitive, example #11: 12 variables" do
#     check all ko2ke_BE4psdw2 <- term(),
#               mGe? <- term(),
#               pDpL! <- term(),
#               kfbYC2esS <- term(),
#               lrcVsmm_uR4_dUry <- term(),
#               usfGB04? <- term(),
#               j <- term(),
#               xjBQMs <- term(),
#               bB? <- term(),
#               vrr_bDtYbBizAPx <- term(),
#               sgsW5_wDdcknC <- term(),
#               e3Z_Qb95pybh? <- term() do
#       # Check for equality with different amounts of whitespace
#       assert ~k[ko2ke_BE4psdw2, mGe?, pDpL!, kfbYC2esS, lrcVsmm_uR4_dUry, usfGB04?, j, xjBQMs, bB?, vrr_bDtYbBizAPx, sgsW5_wDdcknC, e3Z_Qb95pybh?] ==
#                ~k[ko2ke_BE4psdw2,mGe?,  pDpL!,kfbYC2esS,lrcVsmm_uR4_dUry,usfGB04?


# ,j,  xjBQMs,bB?,      vrr_bDtYbBizAPx

# , sgsW5_wDdcknC,
#  e3Z_Qb95pybh?]
#     end
#   end
# end
