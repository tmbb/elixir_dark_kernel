# defmodule DarkKernel.DarkKeywords.VariableRebindingTest do
#   use ExUnit.Case, async: true
#   import ExUnitProperties
#   import StreamData

#   import DarkKernel

#   test "variable rebinding, example #1: 2 variables" do
#     check all tps_Q! <- term(),
#               dy7amI__TGNjx8 <- term(),
#               var1 <- term(),
#               var2 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[tps_Q!, dy7amI__TGNjx8] == [tps_Q!: tps_Q!, dy7amI__TGNjx8: dy7amI__TGNjx8]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[tps_Q!, dy7amI__TGNjx8] = [tps_Q!: var1, dy7amI__TGNjx8: var2]

#       # 2) Assert that each variable has the correct value
#       assert tps_Q! == var1
#       assert dy7amI__TGNjx8 == var2
#     end
#   end

#   test "variable rebinding, example #2: 3 variables" do
#     check all uSJdir0V_ <- term(),
#               xl_lQyfF <- term(),
#               h <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[uSJdir0V_, xl_lQyfF, h] == [uSJdir0V_: uSJdir0V_, xl_lQyfF: xl_lQyfF, h: h]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[uSJdir0V_, xl_lQyfF, h] = [uSJdir0V_: var1, xl_lQyfF: var2, h: var3]

#       # 2) Assert that each variable has the correct value
#       assert uSJdir0V_ == var1
#       assert xl_lQyfF == var2
#       assert h == var3
#     end
#   end

#   test "variable rebinding, example #3: 4 variables" do
#     check all oumtdsSvqRhhns8 <- term(),
#               dpemelZDzBmNxR? <- term(),
#               t1 <- term(),
#               gyE6_vH6Q <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[oumtdsSvqRhhns8, dpemelZDzBmNxR?, t1, gyE6_vH6Q] == [
#                oumtdsSvqRhhns8: oumtdsSvqRhhns8,
#                dpemelZDzBmNxR?: dpemelZDzBmNxR?,
#                t1: t1,
#                gyE6_vH6Q: gyE6_vH6Q
#              ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[oumtdsSvqRhhns8, dpemelZDzBmNxR?, t1, gyE6_vH6Q] = [
#         oumtdsSvqRhhns8: var1,
#         dpemelZDzBmNxR?: var2,
#         t1: var3,
#         gyE6_vH6Q: var4
#       ]

#       # 2) Assert that each variable has the correct value
#       assert oumtdsSvqRhhns8 == var1
#       assert dpemelZDzBmNxR? == var2
#       assert t1 == var3
#       assert gyE6_vH6Q == var4
#     end
#   end

#   test "variable rebinding, example #4: 5 variables" do
#     check all nNH? <- term(),
#               mg_BVTcD6BwZ_zw <- term(),
#               wATQGVTf4aBWbgK <- term(),
#               k_uuJQFkR5DAEN? <- term(),
#               mw9__HvJQVBJ1? <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[nNH?, mg_BVTcD6BwZ_zw, wATQGVTf4aBWbgK, k_uuJQFkR5DAEN?, mw9__HvJQVBJ1?] == [
#                nNH?: nNH?,
#                mg_BVTcD6BwZ_zw: mg_BVTcD6BwZ_zw,
#                wATQGVTf4aBWbgK: wATQGVTf4aBWbgK,
#                k_uuJQFkR5DAEN?: k_uuJQFkR5DAEN?,
#                mw9__HvJQVBJ1?: mw9__HvJQVBJ1?
#              ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[nNH?, mg_BVTcD6BwZ_zw, wATQGVTf4aBWbgK, k_uuJQFkR5DAEN?, mw9__HvJQVBJ1?] = [
#         nNH?: var1,
#         mg_BVTcD6BwZ_zw: var2,
#         wATQGVTf4aBWbgK: var3,
#         k_uuJQFkR5DAEN?: var4,
#         mw9__HvJQVBJ1?: var5
#       ]

#       # 2) Assert that each variable has the correct value
#       assert nNH? == var1
#       assert mg_BVTcD6BwZ_zw == var2
#       assert wATQGVTf4aBWbgK == var3
#       assert k_uuJQFkR5DAEN? == var4
#       assert mw9__HvJQVBJ1? == var5
#     end
#   end

#   test "variable rebinding, example #5: 6 variables" do
#     check all wu_nxDn9pfhTR? <- term(),
#               kjhV4vMdLQ__! <- term(),
#               ezVZgPq_ <- term(),
#               zdFxi <- term(),
#               m8shCYPt? <- term(),
#               j3DyFTD3N! <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[wu_nxDn9pfhTR?, kjhV4vMdLQ__!, ezVZgPq_, zdFxi, m8shCYPt?, j3DyFTD3N!] == [
#                wu_nxDn9pfhTR?: wu_nxDn9pfhTR?,
#                kjhV4vMdLQ__!: kjhV4vMdLQ__!,
#                ezVZgPq_: ezVZgPq_,
#                zdFxi: zdFxi,
#                m8shCYPt?: m8shCYPt?,
#                j3DyFTD3N!: j3DyFTD3N!
#              ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[wu_nxDn9pfhTR?, kjhV4vMdLQ__!, ezVZgPq_, zdFxi, m8shCYPt?, j3DyFTD3N!] = [
#         wu_nxDn9pfhTR?: var1,
#         kjhV4vMdLQ__!: var2,
#         ezVZgPq_: var3,
#         zdFxi: var4,
#         m8shCYPt?: var5,
#         j3DyFTD3N!: var6
#       ]

#       # 2) Assert that each variable has the correct value
#       assert wu_nxDn9pfhTR? == var1
#       assert kjhV4vMdLQ__! == var2
#       assert ezVZgPq_ == var3
#       assert zdFxi == var4
#       assert m8shCYPt? == var5
#       assert j3DyFTD3N! == var6
#     end
#   end

#   test "variable rebinding, example #6: 7 variables" do
#     check all hj! <- term(),
#               wtB_mzmt__ObGUH! <- term(),
#               zBS_Yx_PJq9qg_c <- term(),
#               ofVNhfvZNAlNzCF <- term(),
#               tD6_y? <- term(),
#               cFEo_5hsqgn <- term(),
#               z_l9nbV! <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[hj!, wtB_mzmt__ObGUH!, zBS_Yx_PJq9qg_c, ofVNhfvZNAlNzCF, tD6_y?, cFEo_5hsqgn, z_l9nbV!] ==
#                [
#                  hj!: hj!,
#                  wtB_mzmt__ObGUH!: wtB_mzmt__ObGUH!,
#                  zBS_Yx_PJq9qg_c: zBS_Yx_PJq9qg_c,
#                  ofVNhfvZNAlNzCF: ofVNhfvZNAlNzCF,
#                  tD6_y?: tD6_y?,
#                  cFEo_5hsqgn: cFEo_5hsqgn,
#                  z_l9nbV!: z_l9nbV!
#                ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[hj!, wtB_mzmt__ObGUH!, zBS_Yx_PJq9qg_c, ofVNhfvZNAlNzCF, tD6_y?, cFEo_5hsqgn, z_l9nbV!] =
#         [
#           hj!: var1,
#           wtB_mzmt__ObGUH!: var2,
#           zBS_Yx_PJq9qg_c: var3,
#           ofVNhfvZNAlNzCF: var4,
#           tD6_y?: var5,
#           cFEo_5hsqgn: var6,
#           z_l9nbV!: var7
#         ]

#       # 2) Assert that each variable has the correct value
#       assert hj! == var1
#       assert wtB_mzmt__ObGUH! == var2
#       assert zBS_Yx_PJq9qg_c == var3
#       assert ofVNhfvZNAlNzCF == var4
#       assert tD6_y? == var5
#       assert cFEo_5hsqgn == var6
#       assert z_l9nbV! == var7
#     end
#   end

#   test "variable rebinding, example #7: 8 variables" do
#     check all oRFM4 <- term(),
#               poweCklgNmEI4kL7! <- term(),
#               s4T0 <- term(),
#               oAI7wpuHe! <- term(),
#               j_ <- term(),
#               g62W <- term(),
#               rLn_U <- term(),
#               fv35zXp_ <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term(),
#               var8 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[oRFM4, poweCklgNmEI4kL7!, s4T0, oAI7wpuHe!, j_, g62W, rLn_U, fv35zXp_] == [
#                oRFM4: oRFM4,
#                poweCklgNmEI4kL7!: poweCklgNmEI4kL7!,
#                s4T0: s4T0,
#                oAI7wpuHe!: oAI7wpuHe!,
#                j_: j_,
#                g62W: g62W,
#                rLn_U: rLn_U,
#                fv35zXp_: fv35zXp_
#              ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[oRFM4, poweCklgNmEI4kL7!, s4T0, oAI7wpuHe!, j_, g62W, rLn_U, fv35zXp_] = [
#         oRFM4: var1,
#         poweCklgNmEI4kL7!: var2,
#         s4T0: var3,
#         oAI7wpuHe!: var4,
#         j_: var5,
#         g62W: var6,
#         rLn_U: var7,
#         fv35zXp_: var8
#       ]

#       # 2) Assert that each variable has the correct value
#       assert oRFM4 == var1
#       assert poweCklgNmEI4kL7! == var2
#       assert s4T0 == var3
#       assert oAI7wpuHe! == var4
#       assert j_ == var5
#       assert g62W == var6
#       assert rLn_U == var7
#       assert fv35zXp_ == var8
#     end
#   end

#   test "variable rebinding, example #8: 9 variables" do
#     check all eE_fTer_E__o! <- term(),
#               bFeb__Z <- term(),
#               hL_y <- term(),
#               cpfsSGnz_tdF_R <- term(),
#               ce4ADAbZ52 <- term(),
#               sLV_ <- term(),
#               ghE? <- term(),
#               mZMFNtwWuoV <- term(),
#               s <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term(),
#               var8 <- term(),
#               var9 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[eE_fTer_E__o!, bFeb__Z, hL_y, cpfsSGnz_tdF_R, ce4ADAbZ52, sLV_, ghE?, mZMFNtwWuoV, s] ==
#                [
#                  eE_fTer_E__o!: eE_fTer_E__o!,
#                  bFeb__Z: bFeb__Z,
#                  hL_y: hL_y,
#                  cpfsSGnz_tdF_R: cpfsSGnz_tdF_R,
#                  ce4ADAbZ52: ce4ADAbZ52,
#                  sLV_: sLV_,
#                  ghE?: ghE?,
#                  mZMFNtwWuoV: mZMFNtwWuoV,
#                  s: s
#                ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[eE_fTer_E__o!, bFeb__Z, hL_y, cpfsSGnz_tdF_R, ce4ADAbZ52, sLV_, ghE?, mZMFNtwWuoV, s] = [
#         eE_fTer_E__o!: var1,
#         bFeb__Z: var2,
#         hL_y: var3,
#         cpfsSGnz_tdF_R: var4,
#         ce4ADAbZ52: var5,
#         sLV_: var6,
#         ghE?: var7,
#         mZMFNtwWuoV: var8,
#         s: var9
#       ]

#       # 2) Assert that each variable has the correct value
#       assert eE_fTer_E__o! == var1
#       assert bFeb__Z == var2
#       assert hL_y == var3
#       assert cpfsSGnz_tdF_R == var4
#       assert ce4ADAbZ52 == var5
#       assert sLV_ == var6
#       assert ghE? == var7
#       assert mZMFNtwWuoV == var8
#       assert s == var9
#     end
#   end

#   test "variable rebinding, example #9: 10 variables" do
#     check all o5Uh7sBjK8cZZ! <- term(),
#               wvC2oc0_Mts <- term(),
#               aoPu0XBuQ <- term(),
#               g80Uf? <- term(),
#               qEULvB_bO <- term(),
#               bmuBXG? <- term(),
#               bM2! <- term(),
#               li0uaNHGU83? <- term(),
#               pnFLiLgLoY <- term(),
#               cn9_IfzL? <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term(),
#               var8 <- term(),
#               var9 <- term(),
#               var10 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[o5Uh7sBjK8cZZ!, wvC2oc0_Mts, aoPu0XBuQ, g80Uf?, qEULvB_bO, bmuBXG?, bM2!, li0uaNHGU83?, pnFLiLgLoY, cn9_IfzL?] ==
#                [
#                  o5Uh7sBjK8cZZ!: o5Uh7sBjK8cZZ!,
#                  wvC2oc0_Mts: wvC2oc0_Mts,
#                  aoPu0XBuQ: aoPu0XBuQ,
#                  g80Uf?: g80Uf?,
#                  qEULvB_bO: qEULvB_bO,
#                  bmuBXG?: bmuBXG?,
#                  bM2!: bM2!,
#                  li0uaNHGU83?: li0uaNHGU83?,
#                  pnFLiLgLoY: pnFLiLgLoY,
#                  cn9_IfzL?: cn9_IfzL?
#                ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[o5Uh7sBjK8cZZ!, wvC2oc0_Mts, aoPu0XBuQ, g80Uf?, qEULvB_bO, bmuBXG?, bM2!, li0uaNHGU83?, pnFLiLgLoY, cn9_IfzL?] =
#         [
#           o5Uh7sBjK8cZZ!: var1,
#           wvC2oc0_Mts: var2,
#           aoPu0XBuQ: var3,
#           g80Uf?: var4,
#           qEULvB_bO: var5,
#           bmuBXG?: var6,
#           bM2!: var7,
#           li0uaNHGU83?: var8,
#           pnFLiLgLoY: var9,
#           cn9_IfzL?: var10
#         ]

#       # 2) Assert that each variable has the correct value
#       assert o5Uh7sBjK8cZZ! == var1
#       assert wvC2oc0_Mts == var2
#       assert aoPu0XBuQ == var3
#       assert g80Uf? == var4
#       assert qEULvB_bO == var5
#       assert bmuBXG? == var6
#       assert bM2! == var7
#       assert li0uaNHGU83? == var8
#       assert pnFLiLgLoY == var9
#       assert cn9_IfzL? == var10
#     end
#   end

#   test "variable rebinding, example #10: 11 variables" do
#     check all sHI_! <- term(),
#               uN? <- term(),
#               w! <- term(),
#               iT0W_LHOXO <- term(),
#               w4O! <- term(),
#               t68Lr15xF <- term(),
#               xylfzVK5n2Z? <- term(),
#               jv_H6u_Zhkej <- term(),
#               k6yr_xQ_vnXoSZ8 <- term(),
#               b5P3HlvGH_1! <- term(),
#               oPab <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term(),
#               var8 <- term(),
#               var9 <- term(),
#               var10 <- term(),
#               var11 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[sHI_!, uN?, w!, iT0W_LHOXO, w4O!, t68Lr15xF, xylfzVK5n2Z?, jv_H6u_Zhkej, k6yr_xQ_vnXoSZ8, b5P3HlvGH_1!, oPab] ==
#                [
#                  sHI_!: sHI_!,
#                  uN?: uN?,
#                  w!: w!,
#                  iT0W_LHOXO: iT0W_LHOXO,
#                  w4O!: w4O!,
#                  t68Lr15xF: t68Lr15xF,
#                  xylfzVK5n2Z?: xylfzVK5n2Z?,
#                  jv_H6u_Zhkej: jv_H6u_Zhkej,
#                  k6yr_xQ_vnXoSZ8: k6yr_xQ_vnXoSZ8,
#                  b5P3HlvGH_1!: b5P3HlvGH_1!,
#                  oPab: oPab
#                ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[sHI_!, uN?, w!, iT0W_LHOXO, w4O!, t68Lr15xF, xylfzVK5n2Z?, jv_H6u_Zhkej, k6yr_xQ_vnXoSZ8, b5P3HlvGH_1!, oPab] =
#         [
#           sHI_!: var1,
#           uN?: var2,
#           w!: var3,
#           iT0W_LHOXO: var4,
#           w4O!: var5,
#           t68Lr15xF: var6,
#           xylfzVK5n2Z?: var7,
#           jv_H6u_Zhkej: var8,
#           k6yr_xQ_vnXoSZ8: var9,
#           b5P3HlvGH_1!: var10,
#           oPab: var11
#         ]

#       # 2) Assert that each variable has the correct value
#       assert sHI_! == var1
#       assert uN? == var2
#       assert w! == var3
#       assert iT0W_LHOXO == var4
#       assert w4O! == var5
#       assert t68Lr15xF == var6
#       assert xylfzVK5n2Z? == var7
#       assert jv_H6u_Zhkej == var8
#       assert k6yr_xQ_vnXoSZ8 == var9
#       assert b5P3HlvGH_1! == var10
#       assert oPab == var11
#     end
#   end

#   test "variable rebinding, example #11: 12 variables" do
#     check all qVzlQ? <- term(),
#               d! <- term(),
#               miZyQ1Dz1tZEbv <- term(),
#               s4ICRlb8K! <- term(),
#               b_iLzEIj_UUHof? <- term(),
#               h_M_n5yBY74 <- term(),
#               dydBYfqTd! <- term(),
#               vky? <- term(),
#               i? <- term(),
#               xcVGea? <- term(),
#               dwPoUca_Wh <- term(),
#               t8yBUdM <- term(),
#               var1 <- term(),
#               var2 <- term(),
#               var3 <- term(),
#               var4 <- term(),
#               var5 <- term(),
#               var6 <- term(),
#               var7 <- term(),
#               var8 <- term(),
#               var9 <- term(),
#               var10 <- term(),
#               var11 <- term(),
#               var12 <- term() do
#       # Keyword lists built with ~k[] have the value we expect:
#       # -------------------------------------------------------
#       assert ~k[qVzlQ?, d!, miZyQ1Dz1tZEbv, s4ICRlb8K!, b_iLzEIj_UUHof?, h_M_n5yBY74, dydBYfqTd!, vky?, i?, xcVGea?, dwPoUca_Wh, t8yBUdM] ==
#                [
#                  qVzlQ?: qVzlQ?,
#                  d!: d!,
#                  miZyQ1Dz1tZEbv: miZyQ1Dz1tZEbv,
#                  s4ICRlb8K!: s4ICRlb8K!,
#                  b_iLzEIj_UUHof?: b_iLzEIj_UUHof?,
#                  h_M_n5yBY74: h_M_n5yBY74,
#                  dydBYfqTd!: dydBYfqTd!,
#                  vky?: vky?,
#                  i?: i?,
#                  xcVGea?: xcVGea?,
#                  dwPoUca_Wh: dwPoUca_Wh,
#                  t8yBUdM: t8yBUdM
#                ]

#       # Test that variables are rebound successfully:
#       # ---------------------------------------------

#       # 1) Rebind the variables
#       ~k[qVzlQ?, d!, miZyQ1Dz1tZEbv, s4ICRlb8K!, b_iLzEIj_UUHof?, h_M_n5yBY74, dydBYfqTd!, vky?, i?, xcVGea?, dwPoUca_Wh, t8yBUdM] =
#         [
#           qVzlQ?: var1,
#           d!: var2,
#           miZyQ1Dz1tZEbv: var3,
#           s4ICRlb8K!: var4,
#           b_iLzEIj_UUHof?: var5,
#           h_M_n5yBY74: var6,
#           dydBYfqTd!: var7,
#           vky?: var8,
#           i?: var9,
#           xcVGea?: var10,
#           dwPoUca_Wh: var11,
#           t8yBUdM: var12
#         ]

#       # 2) Assert that each variable has the correct value
#       assert qVzlQ? == var1
#       assert d! == var2
#       assert miZyQ1Dz1tZEbv == var3
#       assert s4ICRlb8K! == var4
#       assert b_iLzEIj_UUHof? == var5
#       assert h_M_n5yBY74 == var6
#       assert dydBYfqTd! == var7
#       assert vky? == var8
#       assert i? == var9
#       assert xcVGea? == var10
#       assert dwPoUca_Wh == var11
#       assert t8yBUdM == var12
#     end
#   end
# end
