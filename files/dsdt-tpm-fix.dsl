/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260408 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /sys/firmware/acpi/tables/DSDT
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000B035 (45109)
 *     Revision         0x02
 *     Checksum         0x70
 *     OEM ID           "AMD"
 *     OEM Table ID     "A M I "
 *     OEM Revision     0x03242016 (52699158)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "DSDT", 2, "AMD", "A M I ", 0x03242016)
{
    /*
     * iASL Warning: There were 2 external control methods found during
     * disassembly, but only 0 were resolved (2 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (APTS, MethodObj)    // Warning: Unknown method, guessing 1 arguments
    External (AWAK, MethodObj)    // Warning: Unknown method, guessing 1 arguments

    Name (ENTK, 0x87)
    Name (EXTK, 0xAA)
    Name (IO1B, 0x0280)
    Name (IO1L, 0x10)
    Name (IO2B, 0x0290)
    Name (IO2L, 0x10)
    Name (IO3B, 0x02A0)
    Name (IO3L, 0x10)
    Name (IO4B, 0x02B0)
    Name (IO4L, 0x10)
    Name (SP1O, 0x2E)
    Name (IOES, Zero)
    Name (PEBL, 0x08000000)
    Name (NBTP, 0xFED40000)
    Name (NBTS, 0x5000)
    Name (CPVD, One)
    Name (SMBB, 0x0B20)
    Name (SMBL, 0x20)
    Name (SMB0, 0x0B00)
    Name (SMBM, 0x10)
    Name (PMBS, 0x0800)
    Name (PMLN, 0xA0)
    Name (SMIO, 0xB2)
    Name (GPBS, Zero)
    Name (GPLN, Zero)
    Name (APCB, 0xFEC00000)
    Name (APCL, 0x1000)
    Name (SPIB, 0xFEC10000)
    Name (SPIL, 0x1000)
    Name (HPTB, 0xFED00000)
    Name (HPTL, 0x0400)
    Name (WDTB, Zero)
    Name (WDTL, Zero)
    Name (GIOB, 0xFED81500)
    Name (IOMB, 0xFED80D00)
    Name (SSMB, 0xFED80200)
    Name (CAFS, 0xBB)
    Name (RXST, Zero)
    Name (U3ST, Zero)
    Name (UTDB, Zero)
    Name (ASSB, Zero)
    Name (AOTB, Zero)
    Name (AAXB, Zero)
    Name (PEHP, One)
    Name (SHPC, Zero)
    Name (PEPM, One)
    Name (PEER, One)
    Name (PECS, One)
    Name (ITKE, Zero)
    Name (PEBS, 0xF0000000)
    Name (PELN, 0x08000000)
    Name (CSMI, 0x61)
    Name (DSSP, Zero)
    Name (FHPP, One)
    Name (SMIA, 0xB2)
    Name (SMIB, 0xB3)
    Name (OFST, 0x35)
    Name (TRST, 0x02)
    Name (TCMF, Zero)
    Name (TMF1, Zero)
    Name (TMF2, Zero)
    Name (TMF3, Zero)
    Name (TTPF, Zero)
    Name (DTPT, Zero)
    Name (TTDP, One)
    Name (TPMB, 0x78E37000)
    Name (TPMC, 0x78E3B000)
    Name (TPMM, 0xEF810510)
    Name (FTPM, 0xEF810510)
    Name (PPIM, 0x78E54A98)
    Name (PPIL, 0x1C)
    Name (AMDT, One)
    Name (TPMF, One)
    Name (PPIV, One)
    Name (HIDK, "MSFT0001")
    Name (HIDM, "MSFT0003")
    Name (CIDK, 0x0303D041)
    Name (CIDM, 0x030FD041)
    Name (ATIS, 0xB0)
    Name (MBEC, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        If (Arg0)
        {
            \_SB.DSPI ()
            \_SB.PCI0.NAPE ()
        }

        PXXX (Arg0)
    }

    Method (OSFL, 0, NotSerialized)
    {
        If ((OSVR != Ones))
        {
            Return (OSVR) /* \OSVR */
        }

        If ((PICM == Zero))
        {
            DBG8 = 0xAC
        }

        OSVR = 0x03
        If (CondRefOf (\_OSI, Local0))
        {
            If (_OSI ("Windows 2001"))
            {
                OSVR = 0x04
            }

            If (_OSI ("Windows 2001.1"))
            {
                OSVR = 0x05
            }

            If (_OSI ("FreeBSD"))
            {
                OSVR = 0x06
            }

            If (_OSI ("HP-UX"))
            {
                OSVR = 0x07
            }

            If (_OSI ("OpenVMS"))
            {
                OSVR = 0x08
            }

            If (_OSI ("Windows 2001 SP1"))
            {
                OSVR = 0x09
            }

            If (_OSI ("Windows 2001 SP2"))
            {
                OSVR = 0x0A
            }

            If (_OSI ("Windows 2001 SP3"))
            {
                OSVR = 0x0B
            }

            If (_OSI ("Windows 2006"))
            {
                OSVR = 0x0C
            }

            If (_OSI ("Windows 2006 SP1"))
            {
                OSVR = 0x0D
            }

            If (_OSI ("Windows 2009"))
            {
                OSVR = 0x0E
            }

            If (_OSI ("Windows 2012"))
            {
                OSVR = 0x0F
            }

            If (_OSI ("Windows 2013"))
            {
                OSVR = 0x10
            }

            If (_OSI ("Windows 2015"))
            {
                OSVR = 0x11
            }
        }
        Else
        {
            If (MCTH (_OS, "Microsoft Windows NT"))
            {
                OSVR = Zero
            }

            If (MCTH (_OS, "Microsoft Windows"))
            {
                OSVR = One
            }

            If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
            {
                OSVR = 0x02
            }

            If (MCTH (_OS, "Linux"))
            {
                OSVR = 0x03
            }

            If (MCTH (_OS, "FreeBSD"))
            {
                OSVR = 0x06
            }

            If (MCTH (_OS, "HP-UX"))
            {
                OSVR = 0x07
            }

            If (MCTH (_OS, "OpenVMS"))
            {
                OSVR = 0x08
            }
        }

        Return (OSVR) /* \OSVR */
    }

    Method (GPRW, 2, NotSerialized)
    {
        PRWP [Zero] = Arg0
        Local0 = (SS1 << One)
        Local0 |= (SS2 << 0x02)
        Local0 |= (SS3 << 0x03)
        Local0 |= (SS4 << 0x04)
        If (((One << Arg1) & Local0))
        {
            PRWP [One] = Arg1
        }
        Else
        {
            Local0 >>= One
            If (((OSFL () == One) || (OSFL () == 0x02)))
            {
                FindSetLeftBit (Local0, PRWP [One])
            }
            Else
            {
                FindSetRightBit (Local0, PRWP [One])
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Name (PICM, Zero)
    Method (PXXX, 1, NotSerialized)
    {
        If (Arg0)
        {
            DBG8 = 0xAA
        }
        Else
        {
            DBG8 = 0xAC
        }

        PICM = Arg0
    }

    Name (OSVR, Ones)
    Method (OXXX, 0, NotSerialized)
    {
        If ((OSVR != Ones))
        {
            Return (OSVR) /* \OSVR */
        }

        If ((PICM == Zero))
        {
            DBG8 = 0xAC
        }

        OSVR = 0x03
        If (CondRefOf (\_OSI, Local0))
        {
            If (_OSI ("Windows 2001"))
            {
                OSVR = 0x04
            }

            If (_OSI ("Windows 2001.1"))
            {
                OSVR = 0x05
            }

            If (_OSI ("FreeBSD"))
            {
                OSVR = 0x06
            }

            If (_OSI ("HP-UX"))
            {
                OSVR = 0x07
            }

            If (_OSI ("OpenVMS"))
            {
                OSVR = 0x08
            }

            If (_OSI ("Windows 2001 SP1"))
            {
                OSVR = 0x09
            }

            If (_OSI ("Windows 2001 SP2"))
            {
                OSVR = 0x0A
            }

            If (_OSI ("Windows 2001 SP3"))
            {
                OSVR = 0x0B
            }

            If (_OSI ("Windows 2006"))
            {
                OSVR = 0x0C
            }

            If (_OSI ("Windows 2006 SP1"))
            {
                OSVR = 0x0D
            }

            If (_OSI ("Windows 2009"))
            {
                OSVR = 0x0E
            }

            If (_OSI ("Windows 2012"))
            {
                OSVR = 0x0F
            }

            If (_OSI ("Windows 2013"))
            {
                OSVR = 0x10
            }
        }
        Else
        {
            If (MCTH (_OS, "Microsoft Windows NT"))
            {
                OSVR = Zero
            }

            If (MCTH (_OS, "Microsoft Windows"))
            {
                OSVR = One
            }

            If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
            {
                OSVR = 0x02
            }

            If (MCTH (_OS, "Linux"))
            {
                OSVR = 0x03
            }

            If (MCTH (_OS, "FreeBSD"))
            {
                OSVR = 0x06
            }

            If (MCTH (_OS, "HP-UX"))
            {
                OSVR = 0x07
            }

            If (MCTH (_OS, "OpenVMS"))
            {
                OSVR = 0x08
            }
        }

        Return (OSVR) /* \OSVR */
    }

    Method (MCTH, 2, NotSerialized)
    {
        If ((SizeOf (Arg0) < SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Local0 = (SizeOf (Arg0) + One)
        Name (BUF0, Buffer (Local0){})
        Name (BUF1, Buffer (Local0){})
        BUF0 = Arg0
        BUF1 = Arg1
        While (Local0)
        {
            Local0--
            If ((DerefOf (BUF0 [Local0]) != DerefOf (BUF1 [Local0]
                )))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GXXX, 2, NotSerialized)
    {
        PRWP [Zero] = Arg0
        Local0 = (SS1 << One)
        Local0 |= (SS2 << 0x02)
        Local0 |= (SS3 << 0x03)
        Local0 |= (SS4 << 0x04)
        If (((One << Arg1) & Local0))
        {
            PRWP [One] = Arg1
        }
        Else
        {
            Local0 >>= One
            If (((OXXX () == One) || (OXXX () == 0x02)))
            {
                FindSetLeftBit (Local0, PRWP [One])
            }
            Else
            {
                FindSetRightBit (Local0, PRWP [One])
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Name (WAKP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (UPWP, 1, NotSerialized)
    {
        If (DerefOf (WAKP [Zero]))
        {
            WAKP [One] = Zero
        }
        Else
        {
            WAKP [One] = Arg0
        }
    }

    OperationRegion (DEB0, SystemIO, 0x80, One)
    Field (DEB0, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }

    OperationRegion (DEB1, SystemIO, 0x90, 0x02)
    Field (DEB1, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }

    Name (SS1, Zero)
    Name (SS2, Zero)
    Name (SS3, One)
    Name (SS4, One)
    Name (IOST, 0x0000)
    Name (TOPM, 0x00000000)
    Name (ROMS, 0xFFE00000)
    Name (VGAF, One)
    OperationRegion (DEB2, SystemIO, 0x80, 0x02)
    Field (DEB2, WordAcc, NoLock, Preserve)
    {
        P80H,   16
    }

    Name (OSTY, Ones)
    OperationRegion (ACMS, SystemIO, 0x72, 0x10)
    Field (ACMS, ByteAcc, NoLock, Preserve)
    {
        ICMS,   8, 
        DCMS,   8, 
        Offset (0x0E), 
        P80,    8
    }

    Name (OSCF, Zero)
    Name (GGN2, One)
    OperationRegion (CMPT, SystemIO, 0x0C50, 0x03)
    Field (CMPT, ByteAcc, NoLock, Preserve)
    {
        CMID,   8, 
            ,   6, 
        GPCT,   2, 
        GP0I,   1, 
        GP1I,   1, 
        GP2I,   1, 
        GP3I,   1, 
        GP4I,   1, 
        GP5I,   1, 
        GP6I,   1, 
        GP7I,   1
    }

    OperationRegion (PCFG, SystemMemory, PEBS, 0x02000000)
    Field (PCFG, AnyAcc, NoLock, Preserve)
    {
        Offset (0x20078), 
        Offset (0x2007A), 
        PMSA,   1, 
        Offset (0x28078), 
        Offset (0x2807A), 
        PMSB,   1, 
        Offset (0x48078), 
        Offset (0x4807A), 
        PMSC,   1, 
        Offset (0x8800A), 
        STCL,   16, 
        Offset (0x880FC), 
        RMBA,   32, 
        Offset (0xA0004), 
        SMIE,   1, 
        SMME,   1, 
        Offset (0xA0008), 
        RVID,   8, 
        Offset (0xA0014), 
        SMB1,   32, 
        Offset (0xA0082), 
            ,   2, 
        G31O,   1, 
        Offset (0xA00E1), 
            ,   6, 
        ACIR,   1, 
        Offset (0xA4004), 
        PCMD,   2, 
        Offset (0xA807A), 
        PMS0,   1, 
        Offset (0xA8088), 
        TLS0,   4, 
        Offset (0xA907A), 
        PMS1,   1, 
        Offset (0xA9088), 
        TLS1,   4, 
        Offset (0xAA07A), 
        PMS2,   1, 
        Offset (0xAA088), 
        TLS2,   4, 
        Offset (0xAB07A), 
        PMS3,   1, 
        Offset (0xAB088), 
        TLS3,   4
    }

    OperationRegion (PMIO, SystemIO, 0x0CD6, 0x02)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        INPM,   8, 
        DAPM,   8
    }

    IndexField (INPM, DAPM, ByteAcc, NoLock, Preserve)
    {
            ,   6, 
        HPEN,   1, 
        Offset (0x60), 
        P1EB,   16, 
        Offset (0xC8), 
            ,   2, 
        SPRE,   1, 
        TPDE,   1, 
        Offset (0xF0), 
            ,   3, 
        RSTU,   1
    }

    OperationRegion (ERMM, SystemMemory, 0xFED80000, 0x1800)
    Field (ERMM, AnyAcc, NoLock, Preserve)
    {
        Offset (0x200), 
            ,   9, 
        GESA,   1, 
        Offset (0x208), 
            ,   5, 
        E05C,   1, 
        Offset (0x209), 
        E08C,   1, 
        E09C,   1, 
        E10C,   1, 
        Offset (0x20B), 
            ,   5, 
        E1DC,   1, 
        Offset (0x296), 
            ,   7, 
        TMSE,   1, 
        Offset (0x2B0), 
            ,   2, 
        SLPS,   2, 
        Offset (0x377), 
        EPNM,   1, 
        DPPF,   1, 
        Offset (0x3BB), 
            ,   6, 
        PWDE,   1, 
        Offset (0x3BE), 
            ,   5, 
        ALLS,   1, 
        Offset (0x3F0), 
        PHYD,   1, 
            ,   1, 
            ,   1, 
        US5R,   1, 
        Offset (0x3F6), 
        GECD,   1, 
        Offset (0xD06), 
        G06M,   8, 
        G07M,   8, 
        Offset (0xD0B), 
        G0BM,   8, 
        Offset (0xD0E), 
        G0EM,   8, 
        Offset (0xD14), 
        G14M,   8, 
        Offset (0xD1C), 
        G1CM,   8, 
        Offset (0xD20), 
        G20M,   8, 
        Offset (0xD23), 
        G23M,   8, 
        Offset (0xD2D), 
        G2DM,   8, 
        Offset (0xD37), 
        G37M,   8, 
        Offset (0xD70), 
        G70M,   8, 
        Offset (0xD76), 
        G76M,   8, 
        Offset (0xDAF), 
        GAFM,   8, 
        GB0M,   8, 
        Offset (0xE80), 
            ,   2, 
        IMCS,   1, 
        Offset (0x1518), 
        Offset (0x151A), 
        GE10,   1, 
        Offset (0x1524), 
        Offset (0x1526), 
        GE22,   1, 
        Offset (0x1538), 
        Offset (0x153A), 
        G66I,   1, 
            ,   5, 
        G66O,   1, 
        G66E,   1, 
        Offset (0x1560), 
        Offset (0x1562), 
        G6FI,   1, 
            ,   5, 
        G6FO,   1, 
        G6FE,   1, 
        Offset (0x1604), 
        Offset (0x1606), 
        G50I,   1, 
            ,   5, 
        G50O,   1, 
        G50E,   1, 
        Offset (0x1608), 
        Offset (0x160A), 
        G51I,   1, 
            ,   5, 
        G51O,   1, 
        G51E,   1, 
        Offset (0x1610), 
        Offset (0x1612), 
        G57I,   1, 
            ,   5, 
        G57O,   1, 
        G57E,   1, 
        Offset (0x1618), 
        Offset (0x161A), 
        G59I,   1, 
            ,   5, 
        G59O,   1, 
        G59E,   1
    }

    OperationRegion (ABIO, SystemIO, 0x0CD8, 0x08)
    Field (ABIO, DWordAcc, NoLock, Preserve)
    {
        INAB,   32, 
        DAAB,   32
    }

    Method (RDAB, 1, NotSerialized)
    {
        INAB = Arg0
        Return (DAAB) /* \DAAB */
    }

    Method (WTAB, 2, NotSerialized)
    {
        INAB = Arg0
        DAAB = Arg1
    }

    Method (RWAB, 3, NotSerialized)
    {
        Local0 = (RDAB (Arg0) & Arg1)
        Local1 = (Local0 | Arg2)
        WTAB (Arg0, Local1)
    }

    Method (CABR, 3, NotSerialized)
    {
        Local0 = (Arg0 << 0x05)
        Local1 = (Local0 + Arg1)
        Local2 = (Local1 << 0x18)
        Local3 = (Local2 + Arg2)
        Return (Local3)
    }

    Method (GHPS, 2, NotSerialized)
    {
        If ((Arg0 == Zero))
        {
            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFBFFF, Zero)
            RWAB (CABR (One, Zero, 0x65), 0xFFFFFBFB, Zero)
            Stall (0xC8)
        }

        If ((Arg0 == One))
        {
            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFBFFF, 0x4000)
            RWAB (CABR (One, Zero, 0x65), 0xFFFFFBFB, 0x0404)
            Stall (0xC8)
        }

        If (GGN2)
        {
            If ((Arg0 == Zero))
            {
                GEN2 ()
                Local0 = RDAB (CABR (0x03, 0x02, 0xA5))
                Local0 &= 0xFF
                Local1 = 0x01F4
                While (((Local1 > Zero) && (Local0 != 0x10)))
                {
                    Local0 = RDAB (CABR (0x03, 0x02, 0xA5))
                    Local0 &= 0xFF
                    Local1--
                    Stall (0xC8)
                    Stall (0xC8)
                }

                If ((Local0 != 0x10))
                {
                    GEN1 ()
                }
            }
        }
    }

    Method (GEN2, 0, NotSerialized)
    {
        TLS2 = 0x02
        RWAB (CABR (0x03, 0x02, 0xA4), 0xFFFFFFFE, One)
        RWAB (CABR (0x03, 0x02, 0xA2), 0xFFFFDFFF, 0x2000)
        RWAB (CABR (0x03, 0x02, 0xC0), 0xFFFF7FFF, 0x8000)
        RWAB (CABR (0x03, 0x02, 0xA4), 0xDFFFFFFF, 0x20000000)
        Stall (0xC8)
        Stall (0xC8)
    }

    Method (GEN1, 0, NotSerialized)
    {
        TLS2 = One
        RWAB (CABR (0x03, 0x02, 0xA4), 0xFFFFFFFE, Zero)
        RWAB (CABR (0x03, 0x02, 0xA2), 0xFFFFDFFF, 0x2000)
        Stall (0xC8)
        Stall (0xC8)
    }

    OperationRegion (P1E0, SystemIO, P1EB, 0x04)
    Field (P1E0, ByteAcc, NoLock, Preserve)
    {
            ,   14, 
        PEWS,   1, 
        WSTA,   1, 
            ,   14, 
        PEWD,   1
    }

    Method (SPTS, 1, NotSerialized)
    {
        PCMD = One
        P80 = Arg0
        If (IMCS)
        {
            IBSE ()
        }

        CPMS ()
        CPMS ()
        PEWS = One
    }

    Method (SWAK, 1, NotSerialized)
    {
        If (PICM)
        {
            \_SB.DSPI ()
        }

        If (TMSE)
        {
            TMSE = Zero
        }

        CPMS ()
        CPMS ()
        PEWS = One
        If (IMCS)
        {
            IBWE ()
        }
    }

    Method (TRMD, 1, NotSerialized)
    {
    }

    Method (CPMS, 0, NotSerialized)
    {
        If ((EPNM == Zero))
        {
            PMSA = One
            PMSB = One
            PMSC = One
            PMS0 = One
            PMS1 = One
            PMS2 = One
            PMS3 = One
        }
    }

    Scope (_GPE)
    {
    }

    OperationRegion (IMIO, SystemIO, 0x3E, 0x02)
    Field (IMIO, ByteAcc, NoLock, Preserve)
    {
        IMCX,   8, 
        IMCA,   8
    }

    IndexField (IMCX, IMCA, ByteAcc, NoLock, Preserve)
    {
        Offset (0x80), 
        MSTI,   8, 
        MITS,   8, 
        MRG0,   8, 
        MRG1,   8, 
        MRG2,   8, 
        MRG3,   8
    }

    Method (WACK, 0, NotSerialized)
    {
        Local0 = Zero
        While ((Local0 != 0xFA))
        {
            Local0 = MRG0 /* \MRG0 */
            Sleep (0x0A)
        }
    }

    Method (IBSE, 0, NotSerialized)
    {
        MRG0 = Zero
        MRG1 = 0xB5
        MRG2 = Zero
        MSTI = 0x96
        WACK ()
        MRG0 = Zero
        MRG1 = Zero
        MRG2 = Zero
        MSTI = 0x80
        WACK ()
        Local0 = MRG2 /* \MRG2 */
        Local0 &= 0xFE
        MRG0 = Zero
        MRG1 = Zero
        MRG2 = Local0
        MSTI = 0x81
        WACK ()
        MRG0 = Zero
        MRG1 = One
        MRG2 = Zero
        MSTI = 0x98
        WACK ()
        MRG0 = Zero
        MRG1 = 0xB4
        MRG2 = Zero
        MSTI = 0x96
        WACK ()
    }

    Method (IBWE, 0, NotSerialized)
    {
        MRG0 = Zero
        MRG1 = 0xB5
        MRG2 = Zero
        MSTI = 0x96
        WACK ()
        MRG0 = Zero
        MRG1 = Zero
        MRG2 = Zero
        MSTI = 0x80
        WACK ()
        Local0 = MRG2 /* \MRG2 */
        Local0 |= One
        MRG0 = Zero
        MRG1 = Zero
        MRG2 = Local0
        MSTI = 0x81
        WACK ()
    }

    Scope (_SB)
    {
        Name (PRSA, Buffer (0x06)
        {
             0x23, 0xB0, 0xCC, 0x18, 0x79, 0x00               // #...y.
        })
        Alias (PRSA, PRSB)
        Alias (PRSA, PRSC)
        Alias (PRSA, PRSD)
        Alias (PRSA, PRSE)
        Alias (PRSA, PRSF)
        Alias (PRSA, PRSG)
        Alias (PRSA, PRSH)
        Name (PD00, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }
        })
        Name (AR00, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x29
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x2A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x2B
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x28
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x2B
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x24
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                Zero, 
                0x25
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                Zero, 
                0x26
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                Zero, 
                0x27
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                Zero, 
                0x27
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                Zero, 
                0x2C
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                Zero, 
                0x20
            }
        })
        Name (PG03, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG03, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x1C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x1D
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x1E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x1F
            }
        })
        Name (PG04, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG04, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x20
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x21
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x22
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x23
            }
        })
        Name (PG05, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG05, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x24
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x25
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x26
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x27
            }
        })
        Name (PG0A, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG0A, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x36
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x37
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x34
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x35
            }
        })
        Name (PG0B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG0B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x32
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x33
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x30
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x31
            }
        })
        Name (PG0C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG0C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x2E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x2F
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x2C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x2D
            }
        })
        Name (PG0D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG0D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x2A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x2B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x28
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x29
            }
        })
        Name (PG12, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKE, , 
                Zero
            }
        })
        Name (AG12, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x27
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x25
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x24
            }
        })
        Name (PG15, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKA, , 
                Zero
            }
        })
        Name (AG15, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x29
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x2A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x2B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x28
            }
        })
        Name (PD01, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }
        })
        Name (AR01, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x48
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x49
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x4A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x4B
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x4B
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x44
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                Zero, 
                0x45
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                Zero, 
                0x46
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                Zero, 
                0x47
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                Zero, 
                0x47
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                Zero, 
                0x4C
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                Zero, 
                0x40
            }
        })
        Name (PG1E, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG1E, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x38
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x39
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x3A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x3B
            }
        })
        Name (PG1F, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG1F, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x3C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x3D
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x3E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x3F
            }
        })
        Name (PG20, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG20, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x40
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x41
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x42
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x43
            }
        })
        Name (PG21, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG21, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x44
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x45
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x46
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x47
            }
        })
        Name (PG26, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG26, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x56
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x57
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x54
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x55
            }
        })
        Name (PG27, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG27, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x52
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x53
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x50
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x51
            }
        })
        Name (PG28, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG28, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x4E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x4F
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x4C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x4D
            }
        })
        Name (PG29, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG29, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x4A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x4B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x48
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x49
            }
        })
        Name (PG2E, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKF, , 
                Zero
            }
        })
        Name (AG2E, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x47
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x44
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x45
            }
        })
        Name (PG32, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKA, , 
                Zero
            }
        })
        Name (AG32, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x49
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x4A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x4B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x48
            }
        })
        Name (PD02, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }
        })
        Name (AR02, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x68
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x69
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x6A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x6B
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x6B
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x64
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                Zero, 
                0x65
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                Zero, 
                0x66
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                Zero, 
                0x67
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                Zero, 
                0x67
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                Zero, 
                0x6C
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                Zero, 
                0x60
            }
        })
        Name (PG3B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG3B, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x58
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x59
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x5A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x5B
            }
        })
        Name (PG3C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG3C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x5C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x5D
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x5E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x5F
            }
        })
        Name (PG3D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG3D, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x60
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x61
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x62
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x63
            }
        })
        Name (PG3E, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKH, , 
                Zero
            }
        })
        Name (AG3E, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x64
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x65
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x66
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x67
            }
        })
        Name (PG43, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG43, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x76
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x77
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x74
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x75
            }
        })
        Name (PG44, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG44, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x72
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x73
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x70
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x71
            }
        })
        Name (PG45, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKF, , 
                Zero
            }
        })
        Name (AG45, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x6E
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x6F
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x6C
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x6D
            }
        })
        Name (PG46, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKB, , 
                Zero
            }
        })
        Name (AG46, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x6A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x6B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x68
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x69
            }
        })
        Name (PG4B, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKF, , 
                Zero
            }
        })
        Name (AG4B, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x67
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x64
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x65
            }
        })
        Name (PG4F, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKA, , 
                Zero
            }
        })
        Name (AG4F, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x69
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x6A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x6B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x68
            }
        })
        Name (PD03, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                LNKF, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKG, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                LNKA, , 
                Zero
            }
        })
        Name (AR03, Package (0x0C)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x88
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x89
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x8A
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x8B
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x8B
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x84
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                Zero, 
                0x85
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                Zero, 
                0x86
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                Zero, 
                0x87
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                Zero, 
                0x87
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                Zero, 
                0x8C
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                Zero, 
                0x80
            }
        })
        Name (PG68, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKH, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKE, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKF, , 
                Zero
            }
        })
        Name (AG68, Package (0x03)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x87
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x84
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x85
            }
        })
        Name (PG6C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKD, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKA, , 
                Zero
            }
        })
        Name (AG6C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x89
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x8A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x8B
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x88
            }
        })
        Name (PG80, Package (0x00){})
        Name (AG80, Package (0x00){})
        Name (PG81, Package (0x00){})
        Name (AG81, Package (0x00){})
        Name (PG82, Package (0x00){})
        Name (AG82, Package (0x00){})
        Name (PG83, Package (0x00){})
        Name (AG83, Package (0x00){})
        Name (PG84, Package (0x00){})
        Name (AG84, Package (0x00){})
        Name (PG85, Package (0x00){})
        Name (AG85, Package (0x00){})
        Name (PG87, Package (0x00){})
        Name (AG87, Package (0x00){})
        Name (PG8C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKA, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKB, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKC, , 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKD, , 
                Zero
            }
        })
        Name (AG8C, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x18
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x19
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x1A
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x1B
            }
        })
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN00, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN00 ())
            }

            Name (_UID, Zero)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR00) /* \_SB_.AR00 */
                }

                Return (PD00) /* \_SB_.PD00 */
            }

            Device (AMDN)
            {
                Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
                Name (_UID, 0xC8)  // _UID: Unique ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (NPTR, Buffer (0x0E)
                {
                    /* 0000 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (NPTR, 0x08, PL)
                    CreateDWordField (NPTR, 0x04, PB)
                    PB = PEBS /* \PEBS */
                    PL = PEBL /* \PEBL */
                    Return (NPTR) /* \_SB_.PCI0.AMDN.NPTR */
                }
            }

            Method (NPTS, 1, NotSerialized)
            {
                APTS (Arg0)
            }

            Method (NWAK, 1, NotSerialized)
            {
                AWAK (Arg0)
            }

            Name (CPRB, One)
            Name (LVGA, 0x01)
            Name (STAV, 0x0F)
            Name (BRB, 0x0000)
            Name (BRL, 0x0040)
            Name (IOB, 0x0000)
            Name (IOL, 0x3000)
            Name (MBB, 0xB8000000)
            Name (MBL, 0x02900000)
            Name (MABL, 0x0000010000000000)
            Name (MABH, 0x00010000)
            Name (MAML, 0x00010000)
            Name (MAMH, 0x00010000)
            Name (MALL, 0x0000037E80000000)
            Name (MALH, 0x00010000)
            Name (CRS1, Buffer (0xD6)
            {
                /* 0000 */  0x88, 0x0D, 0x00, 0x02, 0x0C, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x7F, 0x00, 0x00, 0x00, 0x80, 0x00,  // ........
                /* 0010 */  0x47, 0x01, 0xF8, 0x0C, 0xF8, 0x0C, 0x01, 0x08,  // G.......
                /* 0018 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0020 */  0x00, 0x00, 0xAF, 0x03, 0x00, 0x00, 0xB0, 0x03,  // ........
                /* 0028 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0030 */  0xE0, 0x03, 0xF7, 0x0C, 0x00, 0x00, 0x18, 0x09,  // ........
                /* 0038 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0050 */  0x00, 0x0D, 0xFF, 0x0F, 0x00, 0x00, 0x00, 0x03,  // ........
                /* 0058 */  0x87, 0x17, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0068 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x87, 0x17, 0x00, 0x00, 0x0C, 0x01,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00,  // ........
                /* 0080 */  0xFF, 0xFF, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0088 */  0x00, 0x00, 0x02, 0x00, 0x87, 0x17, 0x00, 0x00,  // ........
                /* 0090 */  0x0C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0098 */  0x00, 0x02, 0xFF, 0xFF, 0xDF, 0xFF, 0x00, 0x00,  // ........
                /* 00A0 */  0x00, 0x00, 0x00, 0x00, 0xE0, 0xFD, 0x8A, 0x2B,  // .......+
                /* 00A8 */  0x00, 0x00, 0x0C, 0x03, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 00B0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 00B8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 00C0 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 00C8 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 00D0 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
            })
            Name (CRS2, Buffer (0x94)
            {
                /* 0000 */  0x88, 0x0D, 0x00, 0x02, 0x0C, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x80, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x00,  // ........
                /* 0010 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x87, 0x17, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x00, 0x00, 0x87, 0x17, 0x00, 0x00, 0x0C, 0x03,  // ........
                /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,  // ........
                /* 0058 */  0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x80, 0x8A, 0x2B, 0x00, 0x00,  // .....+..
                /* 0068 */  0x0C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0080 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0088 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0090 */  0x00, 0x00, 0x79, 0x00                           // ..y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (STAV) /* \_SB_.PCI0.STAV */
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                If (CPRB)
                {
                    CreateWordField (CRS1, 0x08, MIN0)
                    CreateWordField (CRS1, 0x0A, MAX0)
                    CreateWordField (CRS1, 0x0E, LEN0)
                    MIN0 = BRB /* \_SB_.PCI0.BRB_ */
                    LEN0 = BRL /* \_SB_.PCI0.BRL_ */
                    Local0 = LEN0 /* \_SB_.PCI0._CRS.LEN0 */
                    MAX0 = (MIN0 + Local0--)
                    CreateWordField (CRS1, 0x50, MIN1)
                    CreateWordField (CRS1, 0x52, MAX1)
                    CreateWordField (CRS1, 0x56, LEN1)
                    If ((IOB == 0x1000))
                    {
                        Local0 = IOL /* \_SB_.PCI0.IOL_ */
                        MAX1 = (IOB + Local0--)
                        Local0 = (MAX1 - MIN1) /* \_SB_.PCI0._CRS.MIN1 */
                        LEN1 = (Local0 + One)
                    }
                    Else
                    {
                        MIN1 = IOB /* \_SB_.PCI0.IOB_ */
                        LEN1 = IOL /* \_SB_.PCI0.IOL_ */
                        Local0 = LEN1 /* \_SB_.PCI0._CRS.LEN1 */
                        MAX1 = (MIN1 + Local0--)
                    }

                    If (((LVGA == One) || (LVGA == 0x55)))
                    {
                        If (VGAF)
                        {
                            CreateWordField (CRS1, 0x40, IMN1)
                            CreateWordField (CRS1, 0x42, IMX1)
                            CreateWordField (CRS1, 0x46, ILN1)
                            IMN1 = 0x03B0
                            IMX1 = 0x03DF
                            ILN1 = 0x30
                            CreateDWordField (CRS1, 0x62, VMN1)
                            CreateDWordField (CRS1, 0x66, VMX1)
                            CreateDWordField (CRS1, 0x6E, VLN1)
                            VMN1 = 0x000A0000
                            VMX1 = 0x000BFFFF
                            VLN1 = 0x00020000
                            VGAF = Zero
                        }
                    }

                    CreateDWordField (CRS1, 0x96, MIN3)
                    CreateDWordField (CRS1, 0x9A, MAX3)
                    CreateDWordField (CRS1, 0xA2, LEN3)
                    MIN3 = MBB /* \_SB_.PCI0.MBB_ */
                    LEN3 = MBL /* \_SB_.PCI0.MBL_ */
                    Local0 = LEN3 /* \_SB_.PCI0._CRS.LEN3 */
                    MAX3 = (MIN3 + Local0--)
                    CreateQWordField (CRS1, 0xB4, MIN8)
                    CreateQWordField (CRS1, 0xBC, MAX8)
                    CreateQWordField (CRS1, 0xCC, LEN8)
                    MIN8 = MABL /* \_SB_.PCI0.MABL */
                    LEN8 = MALL /* \_SB_.PCI0.MALL */
                    Local0 = LEN8 /* \_SB_.PCI0._CRS.LEN8 */
                    MAX8 = (MIN8 + Local0--)
                    Return (CRS1) /* \_SB_.PCI0.CRS1 */
                }
                Else
                {
                    CreateWordField (CRS2, 0x08, MIN2)
                    CreateWordField (CRS2, 0x0A, MAX2)
                    CreateWordField (CRS2, 0x0E, LEN2)
                    MIN2 = BRB /* \_SB_.PCI0.BRB_ */
                    LEN2 = BRL /* \_SB_.PCI0.BRL_ */
                    Local1 = LEN2 /* \_SB_.PCI0._CRS.LEN2 */
                    MAX2 = (MIN2 + Local1--)
                    CreateWordField (CRS2, 0x28, MIN4)
                    CreateWordField (CRS2, 0x2A, MAX4)
                    CreateWordField (CRS2, 0x2E, LEN4)
                    MIN4 = IOB /* \_SB_.PCI0.IOB_ */
                    LEN4 = IOL /* \_SB_.PCI0.IOL_ */
                    Local1 = LEN4 /* \_SB_.PCI0._CRS.LEN4 */
                    MAX4 = (MIN4 + Local1--)
                    If (LVGA)
                    {
                        CreateWordField (CRS2, 0x18, IMN2)
                        CreateWordField (CRS2, 0x1A, IMX2)
                        CreateWordField (CRS2, 0x1E, ILN2)
                        IMN2 = 0x03B0
                        IMX2 = 0x03DF
                        ILN2 = 0x30
                        CreateDWordField (CRS2, 0x3A, VMN2)
                        CreateDWordField (CRS2, 0x3E, VMX2)
                        CreateDWordField (CRS2, 0x46, VLN2)
                        VMN2 = 0x000A0000
                        VMX2 = 0x000BFFFF
                        VLN2 = 0x00020000
                    }

                    CreateDWordField (CRS2, 0x54, MIN5)
                    CreateDWordField (CRS2, 0x58, MAX5)
                    CreateDWordField (CRS2, 0x60, LEN5)
                    MIN5 = MBB /* \_SB_.PCI0.MBB_ */
                    LEN5 = MBL /* \_SB_.PCI0.MBL_ */
                    Local1 = LEN5 /* \_SB_.PCI0._CRS.LEN5 */
                    MAX5 = (MIN5 + Local1--)
                    CreateQWordField (CRS2, 0x72, MIN9)
                    CreateQWordField (CRS2, 0x7A, MAX9)
                    CreateQWordField (CRS2, 0x8A, LEN9)
                    MIN9 = MABL /* \_SB_.PCI0.MABL */
                    LEN9 = MALL /* \_SB_.PCI0.MALL */
                    Local0 = LEN9 /* \_SB_.PCI0._CRS.LEN9 */
                    MAX9 = (MIN9 + Local0--)
                    Return (CRS2) /* \_SB_.PCI0.CRS2 */
                }
            }

            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                Name (SUPP, Zero)
                Name (CTRL, Zero)
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    If (!PEHP)
                    {
                        CTRL &= 0x1E
                    }

                    If (!SHPC)
                    {
                        CTRL &= 0x1D
                    }

                    If (!PEPM)
                    {
                        CTRL &= 0x1B
                    }

                    If (!PEER)
                    {
                        CTRL &= 0x15
                    }

                    If (!PECS)
                    {
                        CTRL &= 0x0F
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI0._OSC.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            OperationRegion (NAPC, PCI_Config, 0xB4, 0x0C)
            Field (NAPC, DWordAcc, NoLock, Preserve)
            {
                NAEX,   32, 
                NAPX,   32, 
                NAPD,   32
            }

            Mutex (NAPM, 0x00)
            Method (NAPE, 0, NotSerialized)
            {
                Acquire (NAPM, 0xFFFF)
                NAEX = Zero
                NAPX = 0x0001C604
                Local0 = NAPD /* \_SB_.PCI0.NAPD */
                Local0 &= 0x0F
                While ((Local0 >= One))
                {
                    Local1 = (Local0 - One)
                    NAEX = Local1
                    NAPX = 0x14300000
                    Local2 = NAPD /* \_SB_.PCI0.NAPD */
                    Local2 &= 0xFFFFFFEF
                    NAPD = Local2
                    Local0--
                }

                NAEX = Zero
                Release (NAPM)
            }

            Method (GPTS, 1, NotSerialized)
            {
            }

            Method (GWAK, 1, NotSerialized)
            {
                If (PICM)
                {
                    NAPE ()
                }
            }

            Device (D0A1)
            {
                Name (_ADR, 0x00010002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG03) /* \_SB_.AG03 */
                    }

                    Return (PG03) /* \_SB_.PG03 */
                }

                Device (D094)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0A2)
            {
                Name (_ADR, 0x00010003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG04) /* \_SB_.AG04 */
                    }

                    Return (PG04) /* \_SB_.PG04 */
                }

                Device (D095)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0A3)
            {
                Name (_ADR, 0x00010004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG05) /* \_SB_.AG05 */
                    }

                    Return (PG05) /* \_SB_.PG05 */
                }

                Device (D096)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0A4)
            {
                Name (_ADR, 0x00010005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0A5)
            {
                Name (_ADR, 0x00010006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0A6)
            {
                Name (_ADR, 0x00010007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0A7)
            {
                Name (_ADR, 0x00020001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0B0)
            {
                Name (_ADR, 0x00030001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG0A) /* \_SB_.AG0A */
                    }

                    Return (PG0A) /* \_SB_.PG0A */
                }

                Device (D097)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0B1)
            {
                Name (_ADR, 0x00030002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG0B) /* \_SB_.AG0B */
                    }

                    Return (PG0B) /* \_SB_.PG0B */
                }

                Device (D098)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0B2)
            {
                Name (_ADR, 0x00030003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG0C) /* \_SB_.AG0C */
                    }

                    Return (PG0C) /* \_SB_.PG0C */
                }

                Device (D099)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0B3)
            {
                Name (_ADR, 0x00030004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG0D) /* \_SB_.AG0D */
                    }

                    Return (PG0D) /* \_SB_.PG0D */
                }

                Device (D09A)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D0B4)
            {
                Name (_ADR, 0x00030005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0B5)
            {
                Name (_ADR, 0x00030006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0B6)
            {
                Name (_ADR, 0x00030007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0B7)
            {
                Name (_ADR, 0x00040001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D0C0)
            {
                Name (_ADR, 0x00070001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x19, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG12) /* \_SB_.AG12 */
                    }

                    Return (PG12) /* \_SB_.PG12 */
                }

                Device (D013)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (XHC0)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (APSP)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (PSPB, 0xEF800000)
                    Name (_STA, 0x0F)  // _STA: Status
                    Name (CRS, Buffer (0x0E)
                    {
                        /* 0000 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, 0x04, PBAS)
                        CreateDWordField (CRS, 0x08, PLEN)
                        PBAS = PSPB /* \_SB_.PCI0.D0C0.APSP.PSPB */
                        PLEN = 0x00100000
                        Return (CRS) /* \_SB_.PCI0.D0C0.APSP.CRS_ */
                    }
                }
            }

            Device (BR15)
            {
                Name (_ADR, 0x00080001)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG15) /* \_SB_.AG15 */
                    }

                    Return (PG15) /* \_SB_.PG15 */
                }

                Device (D016)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (SATA)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (D018)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (D019)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (D01A)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (D01B)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (D01C)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }
            }

            Device (IOMA)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                OperationRegion (NBF2, PCI_Config, Zero, 0x0100)
                Field (NBF2, AnyAcc, NoLock, Preserve)
                {
                    DID,    32, 
                    Offset (0x44), 
                    MBAS,   32
                }

                Device (^UMEM)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x15)  // _UID: Unique ID
                    Name (CRS, Buffer (0x0E)
                    {
                        /* 0000 */  0x86, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, 0x04, BAS3)
                        CreateDWordField (CRS, 0x08, LEN3)
                        If ((^^IOMA.DID != 0xFFFFFFFF))
                        {
                            LEN3 = 0x00080000
                            BAS3 = (^^IOMA.MBAS & 0xFFF80000)
                        }

                        Return (CRS) /* \_SB_.PCI0.UMEM.CRS_ */
                    }
                }
            }

            Device (D075)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (CRS, Buffer (0x14)
                    {
                        /* 0000 */  0x86, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x22, 0x01, 0x00, 0x22,  // ....".."
                        /* 0010 */  0x00, 0x01, 0x79, 0x00                           // ..y.
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((HPEN == One))
                        {
                            If ((OSVR >= 0x0C))
                            {
                                Return (0x0F)
                            }

                            HPEN = Zero
                            Return (One)
                        }

                        Return (One)
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, 0x04, HPTX)
                        CreateDWordField (CRS, 0x08, HPTY)
                        HPTX = HPTB /* \HPTB */
                        HPTY = HPTL /* \HPTL */
                        Return (CRS) /* \_SB_.PCI0.D075.HPET.CRS_ */
                    }
                }
            }

            Device (D07C)
            {
                Name (_ADR, 0x00140000)  // _ADR: Address
            }

            Device (SBRG)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, Buffer (0x15)  // _CRS: Current Resource Settings
                    {
                        /* 0000 */  0x47, 0x01, 0x20, 0x00, 0x20, 0x00, 0x00, 0x02,  // G. . ...
                        /* 0008 */  0x47, 0x01, 0xA0, 0x00, 0xA0, 0x00, 0x00, 0x02,  // G.......
                        /* 0010 */  0x22, 0x04, 0x00, 0x79, 0x00                     // "..y.
                    })
                }

                Device (DMAD)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, Buffer (0x35)  // _CRS: Current Resource Settings
                    {
                        /* 0000 */  0x2A, 0x10, 0x04, 0x47, 0x01, 0x00, 0x00, 0x00,  // *..G....
                        /* 0008 */  0x00, 0x00, 0x10, 0x47, 0x01, 0x81, 0x00, 0x81,  // ...G....
                        /* 0010 */  0x00, 0x00, 0x03, 0x47, 0x01, 0x87, 0x00, 0x87,  // ...G....
                        /* 0018 */  0x00, 0x00, 0x01, 0x47, 0x01, 0x89, 0x00, 0x89,  // ...G....
                        /* 0020 */  0x00, 0x00, 0x03, 0x47, 0x01, 0x8F, 0x00, 0x8F,  // ...G....
                        /* 0028 */  0x00, 0x00, 0x01, 0x47, 0x01, 0xC0, 0x00, 0xC0,  // ...G....
                        /* 0030 */  0x00, 0x00, 0x20, 0x79, 0x00                     // .. y.
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_CRS, Buffer (0x0D)  // _CRS: Current Resource Settings
                    {
                        /* 0000 */  0x47, 0x01, 0x40, 0x00, 0x40, 0x00, 0x00, 0x04,  // G.@.@...
                        /* 0008 */  0x22, 0x01, 0x00, 0x79, 0x00                     // "..y.
                    })
                }

                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (BUF0, Buffer (0x0A)
                    {
                        /* 0000 */  0x47, 0x01, 0x70, 0x00, 0x70, 0x00, 0x00, 0x02,  // G.p.p...
                        /* 0008 */  0x79, 0x00                                       // y.
                    })
                    Name (BUF1, Buffer (0x0D)
                    {
                        /* 0000 */  0x47, 0x01, 0x70, 0x00, 0x70, 0x00, 0x00, 0x02,  // G.p.p...
                        /* 0008 */  0x22, 0x00, 0x01, 0x79, 0x00                     // "..y.
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If ((HPEN == One))
                        {
                            Return (BUF0) /* \_SB_.PCI0.SBRG.RTC0.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.SBRG.RTC0.BUF1 */
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800") /* Microsoft Sound System Compatible Device */)  // _HID: Hardware ID
                    Name (_CRS, Buffer (0x0A)  // _CRS: Current Resource Settings
                    {
                        /* 0000 */  0x47, 0x01, 0x61, 0x00, 0x61, 0x00, 0x00, 0x01,  // G.a.a...
                        /* 0008 */  0x79, 0x00                                       // y.
                    })
                }

                OperationRegion (SMI0, SystemIO, SMIO, One)
                Field (SMI0, ByteAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                Scope (\_SB)
                {
                    Scope (PCI0)
                    {
                        Device (S900)
                        {
                            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                            Name (_UID, 0x0700)  // _UID: Unique ID
                            Name (_STA, 0x0F)  // _STA: Status
                            Name (CRS, Buffer (0x018E)
                            {
                                /* 0000 */  0x47, 0x01, 0x10, 0x00, 0x10, 0x00, 0x00, 0x10,  // G.......
                                /* 0008 */  0x47, 0x01, 0x22, 0x00, 0x22, 0x00, 0x00, 0x1E,  // G."."...
                                /* 0010 */  0x47, 0x01, 0x63, 0x00, 0x63, 0x00, 0x00, 0x01,  // G.c.c...
                                /* 0018 */  0x47, 0x01, 0x65, 0x00, 0x65, 0x00, 0x00, 0x01,  // G.e.e...
                                /* 0020 */  0x47, 0x01, 0x67, 0x00, 0x67, 0x00, 0x00, 0x09,  // G.g.g...
                                /* 0028 */  0x47, 0x01, 0x72, 0x00, 0x72, 0x00, 0x00, 0x0E,  // G.r.r...
                                /* 0030 */  0x47, 0x01, 0x80, 0x00, 0x80, 0x00, 0x00, 0x01,  // G.......
                                /* 0038 */  0x47, 0x01, 0x84, 0x00, 0x84, 0x00, 0x00, 0x03,  // G.......
                                /* 0040 */  0x47, 0x01, 0x88, 0x00, 0x88, 0x00, 0x00, 0x01,  // G.......
                                /* 0048 */  0x47, 0x01, 0x8C, 0x00, 0x8C, 0x00, 0x00, 0x03,  // G.......
                                /* 0050 */  0x47, 0x01, 0x90, 0x00, 0x90, 0x00, 0x00, 0x10,  // G.......
                                /* 0058 */  0x47, 0x01, 0xA2, 0x00, 0xA2, 0x00, 0x00, 0x1E,  // G.......
                                /* 0060 */  0x47, 0x01, 0xB1, 0x00, 0xB1, 0x00, 0x00, 0x01,  // G.......
                                /* 0068 */  0x47, 0x01, 0xE0, 0x00, 0xE0, 0x00, 0x00, 0x10,  // G.......
                                /* 0070 */  0x47, 0x01, 0xD0, 0x04, 0xD0, 0x04, 0x00, 0x02,  // G.......
                                /* 0078 */  0x47, 0x01, 0x0B, 0x04, 0x0B, 0x04, 0x00, 0x01,  // G.......
                                /* 0080 */  0x47, 0x01, 0xD6, 0x04, 0xD6, 0x04, 0x00, 0x01,  // G.......
                                /* 0088 */  0x47, 0x01, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x02,  // G.......
                                /* 0090 */  0x47, 0x01, 0x14, 0x0C, 0x14, 0x0C, 0x00, 0x01,  // G.......
                                /* 0098 */  0x47, 0x01, 0x50, 0x0C, 0x50, 0x0C, 0x00, 0x02,  // G.P.P...
                                /* 00A0 */  0x47, 0x01, 0x52, 0x0C, 0x52, 0x0C, 0x00, 0x01,  // G.R.R...
                                /* 00A8 */  0x47, 0x01, 0x6C, 0x0C, 0x6C, 0x0C, 0x00, 0x01,  // G.l.l...
                                /* 00B0 */  0x47, 0x01, 0x6F, 0x0C, 0x6F, 0x0C, 0x00, 0x01,  // G.o.o...
                                /* 00B8 */  0x47, 0x01, 0xD0, 0x0C, 0xD0, 0x0C, 0x00, 0x02,  // G.......
                                /* 00C0 */  0x47, 0x01, 0xD2, 0x0C, 0xD2, 0x0C, 0x00, 0x02,  // G.......
                                /* 00C8 */  0x47, 0x01, 0xD4, 0x0C, 0xD4, 0x0C, 0x00, 0x02,  // G.......
                                /* 00D0 */  0x47, 0x01, 0xD6, 0x0C, 0xD6, 0x0C, 0x00, 0x02,  // G.......
                                /* 00D8 */  0x47, 0x01, 0xD8, 0x0C, 0xD8, 0x0C, 0x00, 0x08,  // G.......
                                /* 00E0 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                                /* 00E8 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                                /* 00F0 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                                /* 00F8 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                                /* 0100 */  0x47, 0x01, 0x00, 0x09, 0x00, 0x09, 0x00, 0x10,  // G.......
                                /* 0108 */  0x47, 0x01, 0x10, 0x09, 0x10, 0x09, 0x00, 0x10,  // G.......
                                /* 0110 */  0x47, 0x01, 0x60, 0x00, 0x60, 0x00, 0x00, 0x00,  // G.`.`...
                                /* 0118 */  0x47, 0x01, 0x64, 0x00, 0x64, 0x00, 0x00, 0x00,  // G.d.d...
                                /* 0120 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0128 */  0x00, 0x00, 0x00, 0x00, 0x86, 0x09, 0x00, 0x01,  // ........
                                /* 0130 */  0x00, 0x10, 0xC0, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                                /* 0138 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0xDC, 0xFE,  // ........
                                /* 0140 */  0x00, 0x10, 0x00, 0x00, 0x86, 0x09, 0x00, 0x01,  // ........
                                /* 0148 */  0x00, 0x00, 0xE0, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                                /* 0150 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0xD8, 0xFE,  // ........
                                /* 0158 */  0x00, 0x00, 0x01, 0x00, 0x86, 0x09, 0x00, 0x01,  // ........
                                /* 0160 */  0x00, 0x10, 0xD6, 0xFE, 0x00, 0x00, 0x01, 0x00,  // ........
                                /* 0168 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0170 */  0x00, 0x00, 0x00, 0x00, 0x86, 0x09, 0x00, 0x01,  // ........
                                /* 0178 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0180 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,  // ........
                                /* 0188 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
                            })
                            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                            {
                                CreateWordField (CRS, 0xE2, PBB)
                                CreateWordField (CRS, 0xE4, PBH)
                                CreateByteField (CRS, 0xE7, PML)
                                PBB = PMBS /* \PMBS */
                                PBH = PMBS /* \PMBS */
                                PML = PMLN /* \PMLN */
                                If (SMBB)
                                {
                                    CreateWordField (CRS, 0xFA, SMB1)
                                    CreateWordField (CRS, 0xFC, SMH1)
                                    CreateByteField (CRS, 0xFF, SML1)
                                    SMB1 = SMBB /* \SMBB */
                                    SMH1 = SMBB /* \SMBB */
                                    SML1 = SMBL /* \SMBL */
                                    CreateWordField (CRS, 0xF2, SMBZ)
                                    CreateWordField (CRS, 0xF4, SMH0)
                                    CreateByteField (CRS, 0xF7, SML0)
                                    SMBZ = SMB0 /* \SMB0 */
                                    SMH0 = SMB0 /* \SMB0 */
                                    SML0 = SMBM /* \SMBM */
                                }

                                If (GPBS)
                                {
                                    CreateWordField (CRS, 0xEA, IGB)
                                    CreateWordField (CRS, 0xEC, IGH)
                                    CreateByteField (CRS, 0xEF, IGL)
                                    IGB = GPBS /* \GPBS */
                                    IGH = GPBS /* \GPBS */
                                    IGL = GPLN /* \GPLN */
                                }

                                If (APCB)
                                {
                                    CreateDWordField (CRS, 0x0124, APB)
                                    CreateDWordField (CRS, 0x0128, APL)
                                    APB = APCB /* \APCB */
                                    APL = APCL /* \APCL */
                                }

                                If (SPIB)
                                {
                                    CreateDWordField (CRS, 0x016C, SPIB)
                                    CreateDWordField (CRS, 0x0170, SPIL)
                                    SPIB = \SPIB
                                    SPIL = \SPIL
                                }

                                If (WDTB)
                                {
                                    CreateDWordField (CRS, 0x0178, WDTB)
                                    CreateDWordField (CRS, 0x017C, WDTL)
                                    WDTB = \WDTB
                                    WDTL = \WDTL
                                }

                                CreateDWordField (CRS, 0x0184, ROMB)
                                CreateDWordField (CRS, 0x0188, ROML)
                                ROMB = 0xFF000000
                                ROML = 0x01000000
                                Return (CRS) /* \_SB_.PCI0.S900.CRS_ */
                            }
                        }
                    }
                }

                Scope (\_SB)
                {
                    Scope (PCI0)
                    {
                        Scope (SBRG)
                        {
                            Method (RRIO, 4, NotSerialized)
                            {
                                Debug = "RRIO"
                            }

                            Method (RDMA, 3, NotSerialized)
                            {
                                Debug = "rDMA"
                            }
                        }
                    }
                }

                Device (SIO1)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (CRS, Buffer (0x2A)
                    {
                        /* 0000 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                        /* 0008 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                        /* 0010 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                        /* 0018 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                        /* 0020 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // G.......
                        /* 0028 */  0x79, 0x00                                       // y.
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If (((SP1O < 0x03F0) && (SP1O > 0xF0)))
                        {
                            CreateWordField (CRS, 0x02, GPI0)
                            CreateWordField (CRS, 0x04, GPI1)
                            CreateByteField (CRS, 0x07, GPIL)
                            GPI0 = SP1O /* \SP1O */
                            GPI1 = SP1O /* \SP1O */
                            GPIL = 0x02
                        }

                        If (IO1B)
                        {
                            CreateWordField (CRS, 0x0A, GP10)
                            CreateWordField (CRS, 0x0C, GP11)
                            CreateByteField (CRS, 0x0F, GPL1)
                            GP10 = IO1B /* \IO1B */
                            GP11 = IO1B /* \IO1B */
                            GPL1 = IO1L /* \IO1L */
                        }

                        If (IO2B)
                        {
                            CreateWordField (CRS, 0x12, GP20)
                            CreateWordField (CRS, 0x14, GP21)
                            CreateByteField (CRS, 0x17, GPL2)
                            GP20 = IO2B /* \IO2B */
                            GP21 = IO2B /* \IO2B */
                            GPL2 = IO2L /* \IO2L */
                        }

                        If (IO3B)
                        {
                            CreateWordField (CRS, 0x1A, GP30)
                            CreateWordField (CRS, 0x1C, GP31)
                            CreateByteField (CRS, 0x1F, GPL3)
                            GP30 = IO3B /* \IO3B */
                            GP31 = IO3B /* \IO3B */
                            GPL3 = IO3L /* \IO3L */
                        }

                        If (IO4B)
                        {
                            CreateWordField (CRS, 0x22, GP40)
                            CreateWordField (CRS, 0x24, GP41)
                            CreateByteField (CRS, 0x27, GPL4)
                            GP40 = IO4B /* \IO4B */
                            GP41 = IO4B /* \IO4B */
                            GPL4 = IO4L /* \IO4L */
                        }

                        Return (CRS) /* \_SB_.PCI0.SBRG.SIO1.CRS_ */
                    }

                    Name (DCAT, Package (0x15)
                    {
                        0x02, 
                        0x03, 
                        One, 
                        Zero, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0x05, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0x05, 
                        0xFF, 
                        0x06, 
                        0xFF, 
                        0xFF, 
                        0xFF, 
                        0xFF
                    })
                    Mutex (MUT0, 0x00)
                    Method (ENFG, 1, NotSerialized)
                    {
                        Acquire (MUT0, 0x0FFF)
                        INDX = ENTK /* \ENTK */
                        INDX = ENTK /* \ENTK */
                        LDN = Arg0
                    }

                    Method (EXFG, 0, NotSerialized)
                    {
                        INDX = EXTK /* \EXTK */
                        Release (MUT0)
                    }

                    Method (LPTM, 1, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        Local0 = (OPT0 & 0x02)
                        EXFG ()
                        Return (Local0)
                    }

                    Method (UHID, 1, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        Local0 = (OPT0 & 0x10)
                        EXFG ()
                        If (Local0)
                        {
                            Return (0x1005D041)
                        }
                        Else
                        {
                            Return (0x0105D041)
                        }
                    }

                    OperationRegion (IOID, SystemIO, SP1O, 0x02)
                    Field (IOID, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x07), 
                        LDN,    8, 
                        Offset (0x21), 
                        SCF1,   8, 
                        SCF2,   8, 
                        SCF3,   8, 
                        SCF4,   8, 
                        SCF5,   8, 
                        SCF6,   8, 
                        SCF7,   8, 
                        Offset (0x29), 
                        CKCF,   8, 
                        Offset (0x2F), 
                        SCFF,   8, 
                        ACTR,   8, 
                        Offset (0x60), 
                        IOAH,   8, 
                        IOAL,   8, 
                        IOH2,   8, 
                        IOL2,   8, 
                        Offset (0x70), 
                        INTR,   4, 
                        INTT,   4, 
                        Offset (0x74), 
                        DMCH,   8, 
                        Offset (0xE0), 
                        RGE0,   8, 
                        RGE1,   8, 
                        RGE2,   8, 
                        RGE3,   8, 
                        RGE4,   8, 
                        RGE5,   8, 
                        RGE6,   8, 
                        RGE7,   8, 
                        RGE8,   8, 
                        RGE9,   8, 
                        Offset (0xF0), 
                        OPT0,   8, 
                        OPT1,   8, 
                        OPT2,   8, 
                        OPT3,   8, 
                        OPT4,   8, 
                        OPT5,   8, 
                        OPT6,   8, 
                        OPT7,   8, 
                        OPT8,   8, 
                        OPT9,   8
                    }

                    Method (CGLD, 1, NotSerialized)
                    {
                        Return (DerefOf (DCAT [Arg0]))
                    }

                    Method (DSTA, 1, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        Local0 = ACTR /* \_SB_.PCI0.SBRG.SIO1.ACTR */
                        Local1 = ((IOAH << 0x08) | IOAL) /* \_SB_.PCI0.SBRG.SIO1.IOAL */
                        EXFG ()
                        If ((Local0 == 0xFF))
                        {
                            Return (Zero)
                        }

                        Local0 &= One
                        If ((Arg0 < 0x10))
                        {
                            IOST |= (Local0 << Arg0)
                        }

                        If (Local0)
                        {
                            Return (0x0F)
                        }
                        ElseIf ((Arg0 < 0x10))
                        {
                            If (((One << Arg0) & IOST))
                            {
                                Return (0x0D)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                        Else
                        {
                            If (Local1)
                            {
                                Return (0x0D)
                            }

                            Return (Zero)
                        }
                    }

                    Method (DCNT, 2, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        If (((DMCH < 0x04) && ((Local1 = (DMCH & 0x03)) != Zero)))
                        {
                            RDMA (Arg0, Arg1, Local1++)
                        }

                        ACTR = Arg1
                        Local1 = (IOAH << 0x08)
                        Local1 |= IOAL
                        RRIO (Arg0, Arg1, Local1, 0x08)
                        EXFG ()
                    }

                    Name (CRS1, Buffer (0x10)
                    {
                        /* 0000 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,  // G.......
                        /* 0008 */  0x22, 0x00, 0x00, 0x2A, 0x00, 0x00, 0x79, 0x00   // "..*..y.
                    })
                    CreateWordField (CRS1, 0x09, IRQM)
                    CreateByteField (CRS1, 0x0C, DMAM)
                    CreateWordField (CRS1, 0x02, IO11)
                    CreateWordField (CRS1, 0x04, IO12)
                    CreateByteField (CRS1, 0x07, LEN1)
                    Name (CRS2, Buffer (0x18)
                    {
                        /* 0000 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,  // G.......
                        /* 0008 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,  // G.......
                        /* 0010 */  0x22, 0x00, 0x00, 0x2A, 0x00, 0x00, 0x79, 0x00   // "..*..y.
                    })
                    CreateWordField (CRS2, 0x11, IRQE)
                    CreateByteField (CRS2, 0x14, DMAE)
                    CreateWordField (CRS2, 0x02, IO21)
                    CreateWordField (CRS2, 0x04, IO22)
                    CreateByteField (CRS2, 0x07, LEN2)
                    CreateWordField (CRS2, 0x0A, IO31)
                    CreateWordField (CRS2, 0x0C, IO32)
                    CreateByteField (CRS2, 0x0F, LEN3)
                    Name (CRS3, Buffer (0x11)
                    {
                        /* 0000 */  0x47, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,  // G.......
                        /* 0008 */  0x23, 0x00, 0x00, 0x18, 0x2A, 0x00, 0x00, 0x79,  // #...*..y
                        /* 0010 */  0x00                                             // .
                    })
                    CreateWordField (CRS3, 0x09, IRQT)
                    CreateByteField (CRS3, 0x0B, IRQS)
                    CreateByteField (CRS3, 0x0D, DMAT)
                    CreateWordField (CRS3, 0x02, IO41)
                    CreateWordField (CRS3, 0x04, IO42)
                    CreateByteField (CRS3, 0x07, LEN4)
                    Method (DCRS, 2, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        IO11 = (IOAH << 0x08)
                        IO11 |= IOAL /* \_SB_.PCI0.SBRG.SIO1.IO11 */
                        IO12 = IO11 /* \_SB_.PCI0.SBRG.SIO1.IO11 */
                        LEN1 = 0x08
                        If (INTR)
                        {
                            IRQM = (One << INTR) /* \_SB_.PCI0.SBRG.SIO1.INTR */
                        }
                        Else
                        {
                            IRQM = Zero
                        }

                        If (((DMCH > 0x03) || (Arg1 == Zero)))
                        {
                            DMAM = Zero
                        }
                        Else
                        {
                            Local1 = (DMCH & 0x03)
                            DMAM = (One << Local1)
                        }

                        EXFG ()
                        Return (CRS1) /* \_SB_.PCI0.SBRG.SIO1.CRS1 */
                    }

                    Method (DCR2, 2, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        IO21 = (IOAH << 0x08)
                        IO21 |= IOAL /* \_SB_.PCI0.SBRG.SIO1.IO21 */
                        IO22 = IO21 /* \_SB_.PCI0.SBRG.SIO1.IO21 */
                        LEN2 = 0x08
                        IO31 = (IOH2 << 0x08)
                        IO31 |= IOL2 /* \_SB_.PCI0.SBRG.SIO1.IO31 */
                        IO32 = IO31 /* \_SB_.PCI0.SBRG.SIO1.IO31 */
                        LEN3 = 0x08
                        If (INTR)
                        {
                            IRQE = (One << INTR) /* \_SB_.PCI0.SBRG.SIO1.INTR */
                        }
                        Else
                        {
                            IRQE = Zero
                        }

                        If (((DMCH > 0x03) || (Arg1 == Zero)))
                        {
                            DMAE = Zero
                        }
                        Else
                        {
                            Local1 = (DMCH & 0x03)
                            DMAE = (One << Local1)
                        }

                        EXFG ()
                        Return (CRS2) /* \_SB_.PCI0.SBRG.SIO1.CRS2 */
                    }

                    Method (DCR3, 2, NotSerialized)
                    {
                        ENFG (CGLD (Arg0))
                        IO41 = (IOAH << 0x08)
                        IO41 |= IOAL /* \_SB_.PCI0.SBRG.SIO1.IO41 */
                        IO42 = IO41 /* \_SB_.PCI0.SBRG.SIO1.IO41 */
                        LEN4 = 0x08
                        If (INTR)
                        {
                            IRQT = (One << INTR) /* \_SB_.PCI0.SBRG.SIO1.INTR */
                        }
                        Else
                        {
                            IRQT = Zero
                        }

                        If (((DMCH > 0x03) || (Arg1 == Zero)))
                        {
                            DMAT = Zero
                        }
                        Else
                        {
                            Local1 = (DMCH & 0x03)
                            DMAT = (One << Local1)
                        }

                        EXFG ()
                        Return (CRS3) /* \_SB_.PCI0.SBRG.SIO1.CRS3 */
                    }

                    Method (DSRS, 2, NotSerialized)
                    {
                        If (((Arg1 == 0x02) & LPTM (Arg1)))
                        {
                            DSR2 (Arg0, Arg1)
                        }
                        Else
                        {
                            CreateWordField (Arg0, 0x09, IRQM)
                            CreateByteField (Arg0, 0x0C, DMAM)
                            CreateWordField (Arg0, 0x02, IO11)
                            ENFG (CGLD (Arg1))
                            IOAL = (IO11 & 0xFF)
                            IOAH = (IO11 >> 0x08)
                            If (IRQM)
                            {
                                FindSetRightBit (IRQM, Local0)
                                INTR = (Local0 - One)
                            }
                            Else
                            {
                                INTR = Zero
                            }

                            If (DMAM)
                            {
                                FindSetRightBit (DMAM, Local0)
                                DMCH = (Local0 - One)
                            }
                            Else
                            {
                                DMCH = 0x04
                            }

                            EXFG ()
                            DCNT (Arg1, One)
                            Local2 = Arg1
                            If ((Local2 > Zero))
                            {
                                Local2 -= One
                            }
                        }
                    }

                    Method (DSR2, 2, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x11, IRQE)
                        CreateByteField (Arg0, 0x14, DMAE)
                        CreateWordField (Arg0, 0x02, IO21)
                        CreateWordField (Arg0, 0x0A, IO31)
                        ENFG (CGLD (Arg1))
                        IOAL = (IO21 & 0xFF)
                        IOAH = (IO21 >> 0x08)
                        IOL2 = (IO31 & 0xFF)
                        IOH2 = (IO31 >> 0x08)
                        If (IRQE)
                        {
                            FindSetRightBit (IRQE, Local0)
                            INTR = (Local0 - One)
                        }
                        Else
                        {
                            INTR = Zero
                        }

                        If (DMAE)
                        {
                            FindSetRightBit (DMAE, Local0)
                            DMCH = (Local0 - One)
                        }
                        Else
                        {
                            DMCH = 0x04
                        }

                        EXFG ()
                        DCNT (Arg1, One)
                        Local2 = Arg1
                        If ((Local2 > Zero))
                        {
                            Local2 -= One
                        }
                    }

                    Method (DSR3, 2, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x02, IO41)
                        CreateWordField (Arg0, 0x09, IRQT)
                        CreateByteField (Arg0, 0x0B, IRQS)
                        CreateByteField (Arg0, 0x0D, DMAT)
                        ENFG (CGLD (Arg1))
                        IOAL = (IO41 & 0xFF)
                        IOAH = (IO41 >> 0x08)
                        If (IRQT)
                        {
                            FindSetRightBit (IRQT, Local0)
                            INTR = (Local0 - One)
                        }
                        Else
                        {
                            INTR = Zero
                        }

                        If (DMAT)
                        {
                            FindSetRightBit (DMAT, Local0)
                            DMCH = (Local0 - One)
                        }
                        Else
                        {
                            DMCH = 0x04
                        }

                        EXFG ()
                        DCNT (Arg1, One)
                        Local2 = Arg1
                        If ((Local2 > Zero))
                        {
                            Local2 -= One
                        }
                    }

                    Name (PMFG, Zero)
                    Method (SIOS, 1, NotSerialized)
                    {
                        Debug = "SIOS"
                        If ((0x05 != Arg0))
                        {
                            ENFG (0x0A)
                            If ((Arg0 == One))
                            {
                                OPT6 &= 0xCF
                                If (KBFG)
                                {
                                    OPT6 |= 0x10
                                }
                                Else
                                {
                                    OPT6 &= 0xEF
                                }

                                If (MSFG)
                                {
                                    OPT6 |= 0x20
                                }
                                Else
                                {
                                    OPT6 &= 0xDF
                                }

                                OPT3 = 0xFF
                                OPT4 = 0xFF
                                OPT2 |= One
                            }

                            If ((Arg0 >= 0x03))
                            {
                                RGE0 &= 0x9F
                                Local0 = RGE3 /* \_SB_.PCI0.SBRG.SIO1.RGE3 */
                                Sleep (0xC8)
                                If (KBFG)
                                {
                                    RGE0 |= 0x41
                                }
                                Else
                                {
                                    RGE0 &= 0xBE
                                }

                                If (MSFG)
                                {
                                    RGE0 |= 0x22
                                }
                                Else
                                {
                                    RGE0 &= 0xDD
                                }

                                RGE4 |= One
                            }

                            If ((Arg0 == 0x03))
                            {
                                LDN = 0x0A
                                OPT0 |= 0x20
                                RGE4 |= 0x10
                                LDN = 0x0B
                                OPT7 = 0x45
                                If ((OPT7 == 0x87))
                                {
                                    OPT7 = 0x45
                                }
                            }

                            EXFG ()
                        }
                    }

                    Method (SIOW, 1, NotSerialized)
                    {
                        Debug = "SIOW"
                        ENFG (0x0A)
                        If ((Arg0 == One))
                        {
                            PMFG = OPT3 /* \_SB_.PCI0.SBRG.SIO1.OPT3 */
                            OPT3 = 0xFF
                            OPT6 &= 0xCF
                            OPT2 &= 0xFE
                        }

                        If ((Arg0 >= 0x03))
                        {
                            PMFG = RGE3 /* \_SB_.PCI0.SBRG.SIO1.RGE3 */
                            Local0 = RGE3 /* \_SB_.PCI0.SBRG.SIO1.RGE3 */
                            RGE0 &= 0x9F
                            RGE4 &= 0xFE
                        }

                        LDN = 0x0B
                        If ((OPT7 != Zero))
                        {
                            OPT7 = 0x87
                        }

                        LDN = 0x09
                        ACTR |= 0x08
                        OPT5 &= 0xFF
                        LDN = 0x0F
                        RGE5 &= 0xDF
                        SCFF &= 0xF7
                        EXFG ()
                    }

                    Method (SIOH, 0, NotSerialized)
                    {
                        If ((PMFG & 0x08)){}
                        If ((PMFG & 0x10)){}
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (LDN, 0x05)
                    Name (_CID, EisaId ("PNP030B"))  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((IOST & 0x0400))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (_CRS, Buffer (0x15)  // _CRS: Current Resource Settings
                    {
                        /* 0000 */  0x47, 0x01, 0x60, 0x00, 0x60, 0x00, 0x00, 0x01,  // G.`.`...
                        /* 0008 */  0x47, 0x01, 0x64, 0x00, 0x64, 0x00, 0x00, 0x01,  // G.d.d...
                        /* 0010 */  0x22, 0x02, 0x00, 0x79, 0x00                     // "..y.
                    })
                    Name (_PRS, Buffer (0x18)  // _PRS: Possible Resource Settings
                    {
                        /* 0000 */  0x31, 0x00, 0x47, 0x01, 0x60, 0x00, 0x60, 0x00,  // 1.G.`.`.
                        /* 0008 */  0x00, 0x01, 0x47, 0x01, 0x64, 0x00, 0x64, 0x00,  // ..G.d.d.
                        /* 0010 */  0x00, 0x01, 0x22, 0x02, 0x00, 0x38, 0x79, 0x00   // .."..8y.
                    })
                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        KBFG = Arg0
                    }

                    Scope (\)
                    {
                        Name (KBFG, One)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x1D, 0x03))
                    }
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F03") /* Microsoft PS/2-style Mouse */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (LDN, 0x05)
                    Name (_CID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((IOST & 0x4000))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (CRS1, Buffer (0x05)
                    {
                         0x22, 0x00, 0x10, 0x79, 0x00                     // "..y.
                    })
                    Name (CRS2, Buffer (0x15)
                    {
                        /* 0000 */  0x47, 0x01, 0x60, 0x00, 0x60, 0x00, 0x00, 0x01,  // G.`.`...
                        /* 0008 */  0x47, 0x01, 0x64, 0x00, 0x64, 0x00, 0x00, 0x01,  // G.d.d...
                        /* 0010 */  0x22, 0x00, 0x10, 0x79, 0x00                     // "..y.
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        If ((IOST & 0x0400))
                        {
                            Return (CRS1) /* \_SB_.PCI0.SBRG.PS2M.CRS1 */
                        }
                        Else
                        {
                            Return (CRS2) /* \_SB_.PCI0.SBRG.PS2M.CRS2 */
                        }
                    }

                    Name (_PRS, Buffer (0x08)  // _PRS: Possible Resource Settings
                    {
                         0x31, 0x00, 0x22, 0x00, 0x10, 0x38, 0x79, 0x00   // 1."..8y.
                    })
                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        MSFG = Arg0
                    }

                    Scope (\)
                    {
                        Name (MSFG, One)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (GPRW (0x1D, 0x03))
                    }
                }

                Device (HHMD)
                {
                    Name (_HID, EisaId ("PNP0C08") /* ACPI Core Hardware */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (LDN, 0x0B)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (Zero)
                    }
                }

                Device (SGPI)
                {
                    Name (_HID, EisaId ("PNP0C08") /* ACPI Core Hardware */)  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (LDN, 0x09)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (D07E)
            {
                Name (_ADR, 0x00140006)  // _ADR: Address
            }

            Device (D0A0)
            {
                Name (_ADR, 0x00010001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG8C) /* \_SB_.AG8C */
                    }

                    Return (PG8C) /* \_SB_.PG8C */
                }

                Device (PT01)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (PT02)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Device (PT20)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Device (D08F)
                        {
                            Name (_ADR, 0xFFFF)  // _ADR: Address
                        }
                    }

                    Device (PT21)
                    {
                        Name (_ADR, 0x00010000)  // _ADR: Address
                        Device (D090)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                        }
                    }

                    Device (PT22)
                    {
                        Name (_ADR, 0x00020000)  // _ADR: Address
                        Device (D091)
                        {
                            Name (_ADR, 0xFFFF)  // _ADR: Address
                        }
                    }

                    Device (PT23)
                    {
                        Name (_ADR, 0x00030000)  // _ADR: Address
                        Device (D092)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                        }
                    }

                    Device (PT24)
                    {
                        Name (_ADR, 0x00040000)  // _ADR: Address
                        Device (D093)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                        }
                    }

                    Device (PT25)
                    {
                        Name (_ADR, 0x00050000)  // _ADR: Address
                    }

                    Device (PT26)
                    {
                        Name (_ADR, 0x00060000)  // _ADR: Address
                    }

                    Device (PT27)
                    {
                        Name (_ADR, 0x00070000)  // _ADR: Address
                    }
                }

                Device (PTCP)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }

                Device (PTXH)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Device (POT1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x09, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x0,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO9)
                        {
                            Name (_ADR, 0x09)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x09, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x0,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT2)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x1,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO10)
                        {
                            Name (_ADR, 0x0A)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x1,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT3)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x09, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x2,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO11)
                        {
                            Name (_ADR, 0x0B)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x09, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x2,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT4)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x09, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "LEFT",
                                    PLD_VerticalPosition   = "LOWER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x2,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT5)
                        {
                            Name (_ADR, 0x05)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x3,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO13)
                        {
                            Name (_ADR, 0x0D)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x3,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT6)
                        {
                            Name (_ADR, 0x06)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x4,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO14)
                        {
                            Name (_ADR, 0x0E)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x4,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT7)
                        {
                            Name (_ADR, 0x07)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x5,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO15)
                        {
                            Name (_ADR, 0x0F)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x5,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (POT8)
                        {
                            Name (_ADR, 0x08)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x6,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO16)
                        {
                            Name (_ADR, 0x10)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                0x03, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x6,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO17)
                        {
                            Name (_ADR, 0x11)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x0,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x7,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO18)
                        {
                            Name (_ADR, 0x12)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero, 
                                0xFF, 
                                Zero, 
                                Zero
                            })
                        }

                        Device (PO19)
                        {
                            Name (_ADR, 0x13)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0x9,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO20)
                        {
                            Name (_ADR, 0x14)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0xA,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO21)
                        {
                            Name (_ADR, 0x15)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0xB,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO22)
                        {
                            Name (_ADR, 0x16)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0xC,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }

                        Device (PO12)
                        {
                            Name (_ADR, 0x0C)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 
                                Zero, 
                                Zero, 
                                Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "TOP",
                                    PLD_VerticalPosition   = "CENTER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "HORIZONTALRECTANGLE",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x1,
                                    PLD_GroupPosition      = 0xD,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x1,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }
                    }
                }
            }
        }

        Device (S0D1)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN01, 0, NotSerialized)
            {
                Return (One)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN01 ())
            }

            Name (_UID, One)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR01) /* \_SB_.AR01 */
                }

                Return (PD01) /* \_SB_.PD01 */
            }

            Name (CPRB, One)
            Name (LVGA, 0x00)
            Name (STAV, 0x0F)
            Name (BRB, 0x0040)
            Name (BRL, 0x00C0)
            Name (IOB, 0x3000)
            Name (IOL, 0xD000)
            Name (MBB, 0x80000000)
            Name (MBL, 0x02A00000)
            Name (MABL, 0x0000047E80000000)
            Name (MABH, 0x00010000)
            Name (MAML, 0x00010000)
            Name (MAMH, 0x00010000)
            Name (MALL, 0x0000037E80000000)
            Name (MALH, 0x00010000)
            Name (CRS2, Buffer (0x94)
            {
                /* 0000 */  0x88, 0x0D, 0x00, 0x02, 0x0C, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x80, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x00,  // ........
                /* 0010 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x87, 0x17, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x00, 0x00, 0x87, 0x17, 0x00, 0x00, 0x0C, 0x03,  // ........
                /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,  // ........
                /* 0058 */  0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x80, 0x8A, 0x2B, 0x00, 0x00,  // .....+..
                /* 0068 */  0x0C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0080 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0088 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0090 */  0x00, 0x00, 0x79, 0x00                           // ..y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (STAV) /* \_SB_.S0D1.STAV */
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (CRS2, 0x08, MIN2)
                CreateWordField (CRS2, 0x0A, MAX2)
                CreateWordField (CRS2, 0x0E, LEN2)
                MIN2 = BRB /* \_SB_.S0D1.BRB_ */
                LEN2 = BRL /* \_SB_.S0D1.BRL_ */
                Local1 = LEN2 /* \_SB_.S0D1._CRS.LEN2 */
                MAX2 = (MIN2 + Local1--)
                CreateWordField (CRS2, 0x28, MIN4)
                CreateWordField (CRS2, 0x2A, MAX4)
                CreateWordField (CRS2, 0x2E, LEN4)
                MIN4 = IOB /* \_SB_.S0D1.IOB_ */
                LEN4 = IOL /* \_SB_.S0D1.IOL_ */
                Local1 = LEN4 /* \_SB_.S0D1._CRS.LEN4 */
                MAX4 = (MIN4 + Local1--)
                If (LVGA)
                {
                    CreateWordField (CRS2, 0x18, IMN2)
                    CreateWordField (CRS2, 0x1A, IMX2)
                    CreateWordField (CRS2, 0x1E, ILN2)
                    IMN2 = 0x03B0
                    IMX2 = 0x03DF
                    ILN2 = 0x30
                    CreateDWordField (CRS2, 0x3A, VMN2)
                    CreateDWordField (CRS2, 0x3E, VMX2)
                    CreateDWordField (CRS2, 0x46, VLN2)
                    VMN2 = 0x000A0000
                    VMX2 = 0x000BFFFF
                    VLN2 = 0x00020000
                }

                CreateDWordField (CRS2, 0x54, MIN5)
                CreateDWordField (CRS2, 0x58, MAX5)
                CreateDWordField (CRS2, 0x60, LEN5)
                MIN5 = MBB /* \_SB_.S0D1.MBB_ */
                LEN5 = MBL /* \_SB_.S0D1.MBL_ */
                Local1 = LEN5 /* \_SB_.S0D1._CRS.LEN5 */
                MAX5 = (MIN5 + Local1--)
                CreateQWordField (CRS2, 0x72, MIN9)
                CreateQWordField (CRS2, 0x7A, MAX9)
                CreateQWordField (CRS2, 0x8A, LEN9)
                MIN9 = MABL /* \_SB_.S0D1.MABL */
                LEN9 = MALL /* \_SB_.S0D1.MALL */
                Local0 = LEN9 /* \_SB_.S0D1._CRS.LEN9 */
                MAX9 = (MIN9 + Local0--)
                Return (CRS2) /* \_SB_.S0D1.CRS2 */
            }

            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                Name (SUPP, Zero)
                Name (CTRL, Zero)
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.S0D1._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.S0D1._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    If (!PEHP)
                    {
                        CTRL &= 0x1E
                    }

                    If (!SHPC)
                    {
                        CTRL &= 0x1D
                    }

                    If (!PEPM)
                    {
                        CTRL &= 0x1B
                    }

                    If (!PEER)
                    {
                        CTRL &= 0x15
                    }

                    If (!PECS)
                    {
                        CTRL &= 0x0F
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.S0D1._OSC.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Device (D1A0)
            {
                Name (_ADR, 0x00010001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG1E) /* \_SB_.AG1E */
                    }

                    Return (PG1E) /* \_SB_.PG1E */
                }

                Device (D09B)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1A1)
            {
                Name (_ADR, 0x00010002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG1F) /* \_SB_.AG1F */
                    }

                    Return (PG1F) /* \_SB_.PG1F */
                }

                Device (D09C)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1A2)
            {
                Name (_ADR, 0x00010003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG20) /* \_SB_.AG20 */
                    }

                    Return (PG20) /* \_SB_.PG20 */
                }

                Device (D09D)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1A3)
            {
                Name (_ADR, 0x00010004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG21) /* \_SB_.AG21 */
                    }

                    Return (PG21) /* \_SB_.PG21 */
                }

                Device (D09E)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1A4)
            {
                Name (_ADR, 0x00010005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1A5)
            {
                Name (_ADR, 0x00010006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1A6)
            {
                Name (_ADR, 0x00010007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1A7)
            {
                Name (_ADR, 0x00020001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1B0)
            {
                Name (_ADR, 0x00030001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG26) /* \_SB_.AG26 */
                    }

                    Return (PG26) /* \_SB_.PG26 */
                }

                Device (D09F)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1B1)
            {
                Name (_ADR, 0x00030002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG27) /* \_SB_.AG27 */
                    }

                    Return (PG27) /* \_SB_.PG27 */
                }

                Device (D0A0)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1B2)
            {
                Name (_ADR, 0x00030003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG28) /* \_SB_.AG28 */
                    }

                    Return (PG28) /* \_SB_.PG28 */
                }

                Device (D0A1)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1B3)
            {
                Name (_ADR, 0x00030004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG29) /* \_SB_.AG29 */
                    }

                    Return (PG29) /* \_SB_.PG29 */
                }

                Device (D0A2)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D1B4)
            {
                Name (_ADR, 0x00030005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1B5)
            {
                Name (_ADR, 0x00030006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1B6)
            {
                Name (_ADR, 0x00030007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1B7)
            {
                Name (_ADR, 0x00040001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D1C0)
            {
                Name (_ADR, 0x00070001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x14, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG2E) /* \_SB_.AG2E */
                    }

                    Return (PG2E) /* \_SB_.PG2E */
                }

                Device (D02F)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (D030)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (XHC0)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }
            }

            Device (BR32)
            {
                Name (_ADR, 0x00080001)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG32) /* \_SB_.AG32 */
                    }

                    Return (PG32) /* \_SB_.PG32 */
                }

                Device (D033)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (SATA)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (D035)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (D036)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (D037)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (D038)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (D039)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }
            }

            Device (IOMB)
            {
                Name (_ADR, 0x02)  // _ADR: Address
                OperationRegion (NBF2, PCI_Config, Zero, 0x0100)
                Field (NBF2, AnyAcc, NoLock, Preserve)
                {
                    DID,    32, 
                    Offset (0x44), 
                    MBAS,   32
                }

                Device (^UMEM)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x15)  // _UID: Unique ID
                    Name (CRS, Buffer (0x0E)
                    {
                        /* 0000 */  0x86, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x79, 0x00               // ....y.
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (CRS, 0x04, BAS3)
                        CreateDWordField (CRS, 0x08, LEN3)
                        If ((^^IOMB.DID != 0xFFFFFFFF))
                        {
                            LEN3 = 0x00080000
                            BAS3 = (^^IOMB.MBAS & 0xFFF80000)
                        }

                        Return (CRS) /* \_SB_.S0D1.UMEM.CRS_ */
                    }
                }
            }

            Device (D077)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }
        }

        Device (S0D2)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN02, 0, NotSerialized)
            {
                Return (0x02)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN02 ())
            }

            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR02) /* \_SB_.AR02 */
                }

                Return (PD02) /* \_SB_.PD02 */
            }

            Name (CPRB, One)
            Name (LVGA, 0x00)
            Name (STAV, 0x00)
            Name (BRB, 0x0000)
            Name (BRL, 0x0000)
            Name (IOB, 0x0000)
            Name (IOL, 0x0000)
            Name (MBB, 0x00000000)
            Name (MBL, 0x00000000)
            Name (MABL, 0x0000000000000000)
            Name (MABH, 0x00010000)
            Name (MAML, 0x00010000)
            Name (MAMH, 0x00010000)
            Name (MALL, 0x0000000000000000)
            Name (MALH, 0x00010000)
            Name (CRS2, Buffer (0x94)
            {
                /* 0000 */  0x88, 0x0D, 0x00, 0x02, 0x0C, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x80, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x00,  // ........
                /* 0010 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x87, 0x17, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x00, 0x00, 0x87, 0x17, 0x00, 0x00, 0x0C, 0x03,  // ........
                /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,  // ........
                /* 0058 */  0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x80, 0x8A, 0x2B, 0x00, 0x00,  // .....+..
                /* 0068 */  0x0C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0080 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0088 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0090 */  0x00, 0x00, 0x79, 0x00                           // ..y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (STAV) /* \_SB_.S0D2.STAV */
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (CRS2, 0x08, MIN2)
                CreateWordField (CRS2, 0x0A, MAX2)
                CreateWordField (CRS2, 0x0E, LEN2)
                MIN2 = BRB /* \_SB_.S0D2.BRB_ */
                LEN2 = BRL /* \_SB_.S0D2.BRL_ */
                Local1 = LEN2 /* \_SB_.S0D2._CRS.LEN2 */
                MAX2 = (MIN2 + Local1--)
                CreateWordField (CRS2, 0x28, MIN4)
                CreateWordField (CRS2, 0x2A, MAX4)
                CreateWordField (CRS2, 0x2E, LEN4)
                MIN4 = IOB /* \_SB_.S0D2.IOB_ */
                LEN4 = IOL /* \_SB_.S0D2.IOL_ */
                Local1 = LEN4 /* \_SB_.S0D2._CRS.LEN4 */
                MAX4 = (MIN4 + Local1--)
                If (LVGA)
                {
                    CreateWordField (CRS2, 0x18, IMN2)
                    CreateWordField (CRS2, 0x1A, IMX2)
                    CreateWordField (CRS2, 0x1E, ILN2)
                    IMN2 = 0x03B0
                    IMX2 = 0x03DF
                    ILN2 = 0x30
                    CreateDWordField (CRS2, 0x3A, VMN2)
                    CreateDWordField (CRS2, 0x3E, VMX2)
                    CreateDWordField (CRS2, 0x46, VLN2)
                    VMN2 = 0x000A0000
                    VMX2 = 0x000BFFFF
                    VLN2 = 0x00020000
                }

                CreateDWordField (CRS2, 0x54, MIN5)
                CreateDWordField (CRS2, 0x58, MAX5)
                CreateDWordField (CRS2, 0x60, LEN5)
                MIN5 = MBB /* \_SB_.S0D2.MBB_ */
                LEN5 = MBL /* \_SB_.S0D2.MBL_ */
                Local1 = LEN5 /* \_SB_.S0D2._CRS.LEN5 */
                MAX5 = (MIN5 + Local1--)
                CreateQWordField (CRS2, 0x72, MIN9)
                CreateQWordField (CRS2, 0x7A, MAX9)
                CreateQWordField (CRS2, 0x8A, LEN9)
                MIN9 = MABL /* \_SB_.S0D2.MABL */
                LEN9 = MALL /* \_SB_.S0D2.MALL */
                Local0 = LEN9 /* \_SB_.S0D2._CRS.LEN9 */
                MAX9 = (MIN9 + Local0--)
                Return (CRS2) /* \_SB_.S0D2.CRS2 */
            }

            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                Name (SUPP, Zero)
                Name (CTRL, Zero)
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.S0D2._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.S0D2._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    If (!PEHP)
                    {
                        CTRL &= 0x1E
                    }

                    If (!SHPC)
                    {
                        CTRL &= 0x1D
                    }

                    If (!PEPM)
                    {
                        CTRL &= 0x1B
                    }

                    If (!PEER)
                    {
                        CTRL &= 0x15
                    }

                    If (!PECS)
                    {
                        CTRL &= 0x0F
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.S0D2._OSC.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Device (D2A0)
            {
                Name (_ADR, 0x00010001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG3B) /* \_SB_.AG3B */
                    }

                    Return (PG3B) /* \_SB_.PG3B */
                }

                Device (D0A3)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2A1)
            {
                Name (_ADR, 0x00010002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG3C) /* \_SB_.AG3C */
                    }

                    Return (PG3C) /* \_SB_.PG3C */
                }

                Device (D0A4)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2A2)
            {
                Name (_ADR, 0x00010003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG3D) /* \_SB_.AG3D */
                    }

                    Return (PG3D) /* \_SB_.PG3D */
                }

                Device (D0A5)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2A3)
            {
                Name (_ADR, 0x00010004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG3E) /* \_SB_.AG3E */
                    }

                    Return (PG3E) /* \_SB_.PG3E */
                }

                Device (D0A6)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2A4)
            {
                Name (_ADR, 0x00010005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2A5)
            {
                Name (_ADR, 0x00010006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2A6)
            {
                Name (_ADR, 0x00010007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2A7)
            {
                Name (_ADR, 0x00020001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2B0)
            {
                Name (_ADR, 0x00030001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG43) /* \_SB_.AG43 */
                    }

                    Return (PG43) /* \_SB_.PG43 */
                }

                Device (D0A7)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2B1)
            {
                Name (_ADR, 0x00030002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG44) /* \_SB_.AG44 */
                    }

                    Return (PG44) /* \_SB_.PG44 */
                }

                Device (D0A8)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2B2)
            {
                Name (_ADR, 0x00030003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG45) /* \_SB_.AG45 */
                    }

                    Return (PG45) /* \_SB_.PG45 */
                }

                Device (D0A9)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2B3)
            {
                Name (_ADR, 0x00030004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG46) /* \_SB_.AG46 */
                    }

                    Return (PG46) /* \_SB_.PG46 */
                }

                Device (D0AA)
                {
                    Name (_ADR, 0xFFFF)  // _ADR: Address
                }
            }

            Device (D2B4)
            {
                Name (_ADR, 0x00030005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2B5)
            {
                Name (_ADR, 0x00030006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2B6)
            {
                Name (_ADR, 0x00030007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D2B7)
            {
                Name (_ADR, 0x00040001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (S0D2)
            {
                Name (_ADR, 0x00070001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x14, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG4B) /* \_SB_.AG4B */
                    }

                    Return (PG4B) /* \_SB_.PG4B */
                }

                Device (D04C)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (D04D)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (XHC0)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }
            }

            Device (BR4F)
            {
                Name (_ADR, 0x00080001)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG4F) /* \_SB_.AG4F */
                    }

                    Return (PG4F) /* \_SB_.PG4F */
                }

                Device (D050)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (SATA)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Name (B5EN, Zero)
                    Name (BA_5, Zero)
                    Name (SBAR, 0xF0B6F000)
                    Name (OSVR, Zero)
                    Name (SAD0, Zero)
                    Name (SAD3, Zero)
                    PowerResource (P0SA, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (SAD0) /* \_SB_.S0D2.BR4F.SATA.SAD0 */
                        }

                        Method (_ON, 0, NotSerialized)  // _ON_: Power On
                        {
                            DBG8 = 0xA1
                            SAD0 = One
                        }

                        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                        {
                            DBG8 = 0xA2
                            SAD0 = Zero
                        }
                    }

                    PowerResource (P3SA, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (SAD3) /* \_SB_.S0D2.BR4F.SATA.SAD3 */
                        }

                        Method (_ON, 0, NotSerialized)  // _ON_: Power On
                        {
                            DBG8 = 0xA4
                            SAD3 = One
                        }

                        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                        {
                            DBG8 = 0xA5
                            SAD3 = Zero
                        }
                    }

                    OperationRegion (SATX, PCI_Config, Zero, 0x44)
                    Field (SATX, AnyAcc, NoLock, Preserve)
                    {
                        VIDI,   32, 
                        Offset (0x0A), 
                        STCL,   16, 
                        Offset (0x24), 
                        BA05,   32, 
                        Offset (0x40), 
                        WTEN,   1, 
                        Offset (0x42), 
                        DIS0,   1, 
                        DIS1,   1, 
                        DIS2,   1, 
                        DIS3,   1, 
                        DIS4,   1, 
                        DIS5,   1
                    }

                    Field (SATX, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x42), 
                        DISP,   6
                    }

                    Method (GBAA, 0, Serialized)
                    {
                        BA_5 = BA05 /* \_SB_.S0D2.BR4F.SATA.BA05 */
                        If (((BA_5 == Ones) || (STCL != 0x0101)))
                        {
                            B5EN = Zero
                            Return (SBAR) /* \_SB_.S0D2.BR4F.SATA.SBAR */
                        }
                        Else
                        {
                            B5EN = One
                            Return (BA_5) /* \_SB_.S0D2.BR4F.SATA.BA_5 */
                        }
                    }

                    OperationRegion (BAR5, SystemMemory, GBAA (), 0x1000)
                    Field (BAR5, AnyAcc, NoLock, Preserve)
                    {
                        NOPT,   5, 
                        Offset (0x0C), 
                        PTI0,   1, 
                        PTI1,   1, 
                        PTI2,   1, 
                        PTI3,   1, 
                        PTI4,   1, 
                        PTI5,   1, 
                        PTI6,   1, 
                        PTI7,   1, 
                        Offset (0x118), 
                        CST0,   1, 
                        Offset (0x120), 
                            ,   7, 
                        BSY0,   1, 
                        Offset (0x128), 
                        DET0,   4, 
                        Offset (0x129), 
                        IPM0,   4, 
                        Offset (0x12C), 
                        DDI0,   4, 
                        Offset (0x198), 
                        CST1,   1, 
                        Offset (0x1A0), 
                            ,   7, 
                        BSY1,   1, 
                        Offset (0x1A8), 
                        DET1,   4, 
                        Offset (0x1A9), 
                        IPM1,   4, 
                        Offset (0x1AC), 
                        DDI1,   4, 
                        Offset (0x218), 
                        CST2,   1, 
                        Offset (0x220), 
                            ,   7, 
                        BSY2,   1, 
                        Offset (0x228), 
                        DET2,   4, 
                        Offset (0x229), 
                        IPM2,   4, 
                        Offset (0x22C), 
                        DDI2,   4, 
                        Offset (0x298), 
                        CST3,   1, 
                        Offset (0x2A0), 
                            ,   7, 
                        BSY3,   1, 
                        Offset (0x2A8), 
                        DET3,   4, 
                        Offset (0x2A9), 
                        IPM3,   4, 
                        Offset (0x2AC), 
                        DDI3,   4, 
                        Offset (0x318), 
                        CST4,   1, 
                        Offset (0x320), 
                            ,   7, 
                        BSY4,   1, 
                        Offset (0x328), 
                        DET4,   4, 
                        Offset (0x329), 
                        IPM4,   4, 
                        Offset (0x32C), 
                        DDI4,   4, 
                        Offset (0x398), 
                        CST5,   1, 
                        Offset (0x3A0), 
                            ,   7, 
                        BSY5,   1, 
                        Offset (0x3A8), 
                        DET5,   4, 
                        Offset (0x3A9), 
                        IPM5,   4, 
                        Offset (0x3AC), 
                        DDI5,   4
                    }

                    Field (BAR5, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x0C), 
                        PTI,    6
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        GBAA ()
                    }

                    Device (PRID)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Name (SPTM, Buffer (0x14)
                        {
                            /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0010 */  0x1F, 0x00, 0x00, 0x00                           // ....
                        })
                        Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                        {
                            Return (SPTM) /* \_SB_.S0D2.BR4F.SATA.PRID.SPTM */
                        }

                        Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                        {
                            SPTM = Arg0
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((OSVR >= 0x0C) || (OSVR == Zero)) && B5EN))
                            {
                                If (IPM2)
                                {
                                    Local0 = 0x32
                                    While (((BSY2 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Device (P_D0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET0 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Name (S12P, Zero)
                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY0 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }

                        Device (P_D1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET2 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Name (S12P, Zero)
                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY2 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }
                    }

                    Device (SECD)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Name (SPTM, Buffer (0x14)
                        {
                            /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0010 */  0x1F, 0x00, 0x00, 0x00                           // ....
                        })
                        Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                        {
                            Return (SPTM) /* \_SB_.S0D2.BR4F.SATA.SECD.SPTM */
                        }

                        Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                        {
                            SPTM = Arg0
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((OSVR >= 0x0C) || (OSVR == Zero)) && B5EN))
                            {
                                If (IPM1)
                                {
                                    Local0 = 0x32
                                    While (((BSY1 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }

                                If (IPM3)
                                {
                                    Local0 = 0x32
                                    While (((BSY3 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Device (S_D0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET1 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY1 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }

                        Device (S_D1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET3 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY3 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }
                    }

                    Method (ENP, 2, NotSerialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            DIS0 = ~Arg1
                        }
                        ElseIf ((Arg0 == One))
                        {
                            DIS1 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            DIS2 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            DIS3 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x04))
                        {
                            DIS4 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x05))
                        {
                            DIS5 = ~Arg1
                        }

                        WTEN = One
                        If ((Arg0 == Zero))
                        {
                            PTI0 = Arg1
                        }
                        ElseIf ((Arg0 == One))
                        {
                            PTI1 = Arg1
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            PTI2 = Arg1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            PTI3 = Arg1
                        }
                        ElseIf ((Arg0 == 0x04))
                        {
                            PTI4 = Arg1
                        }
                        ElseIf ((Arg0 == 0x05))
                        {
                            PTI5 = Arg1
                        }

                        If ((DISP == 0x3F))
                        {
                            PTI0 = One
                        }
                        ElseIf ((DIS0 && ((DISP & 0x3E) ^ 0x3E)))
                        {
                            PTI0 = Zero
                        }

                        Local0 = PTI /* \_SB_.S0D2.BR4F.SATA.PTI_ */
                        Local1 = Zero
                        While (Local0)
                        {
                            If ((Local0 & One))
                            {
                                Local1++
                            }

                            Local0 >>= One
                        }

                        NOPT = Local1--
                        WTEN = Zero
                    }
                }

                Device (D052)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (D053)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (D054)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (D055)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (D056)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }
            }
        }

        Device (S0D3)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN03, 0, NotSerialized)
            {
                Return (0x03)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN03 ())
            }

            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR03) /* \_SB_.AR03 */
                }

                Return (PD03) /* \_SB_.PD03 */
            }

            Name (CPRB, One)
            Name (LVGA, 0x00)
            Name (STAV, 0x00)
            Name (BRB, 0x0000)
            Name (BRL, 0x0000)
            Name (IOB, 0x0000)
            Name (IOL, 0x0000)
            Name (MBB, 0x00000000)
            Name (MBL, 0x00000000)
            Name (MABL, 0x0000000000000000)
            Name (MABH, 0x00010000)
            Name (MAML, 0x00010000)
            Name (MAMH, 0x00010000)
            Name (MALL, 0x0000000000000000)
            Name (MALH, 0x00010000)
            Name (CRS2, Buffer (0x94)
            {
                /* 0000 */  0x88, 0x0D, 0x00, 0x02, 0x0C, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x80, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x80, 0x00,  // ........
                /* 0010 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x88, 0x0D, 0x00, 0x01, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x87, 0x17, 0x00, 0x00, 0x0C, 0x03, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x00, 0x00, 0x87, 0x17, 0x00, 0x00, 0x0C, 0x03,  // ........
                /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,  // ........
                /* 0058 */  0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x80, 0x8A, 0x2B, 0x00, 0x00,  // .....+..
                /* 0068 */  0x0C, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0080 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0088 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0090 */  0x00, 0x00, 0x79, 0x00                           // ..y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (STAV) /* \_SB_.S0D3.STAV */
            }

            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (CRS2, 0x08, MIN2)
                CreateWordField (CRS2, 0x0A, MAX2)
                CreateWordField (CRS2, 0x0E, LEN2)
                MIN2 = BRB /* \_SB_.S0D3.BRB_ */
                LEN2 = BRL /* \_SB_.S0D3.BRL_ */
                Local1 = LEN2 /* \_SB_.S0D3._CRS.LEN2 */
                MAX2 = (MIN2 + Local1--)
                CreateWordField (CRS2, 0x28, MIN4)
                CreateWordField (CRS2, 0x2A, MAX4)
                CreateWordField (CRS2, 0x2E, LEN4)
                MIN4 = IOB /* \_SB_.S0D3.IOB_ */
                LEN4 = IOL /* \_SB_.S0D3.IOL_ */
                Local1 = LEN4 /* \_SB_.S0D3._CRS.LEN4 */
                MAX4 = (MIN4 + Local1--)
                If (LVGA)
                {
                    CreateWordField (CRS2, 0x18, IMN2)
                    CreateWordField (CRS2, 0x1A, IMX2)
                    CreateWordField (CRS2, 0x1E, ILN2)
                    IMN2 = 0x03B0
                    IMX2 = 0x03DF
                    ILN2 = 0x30
                    CreateDWordField (CRS2, 0x3A, VMN2)
                    CreateDWordField (CRS2, 0x3E, VMX2)
                    CreateDWordField (CRS2, 0x46, VLN2)
                    VMN2 = 0x000A0000
                    VMX2 = 0x000BFFFF
                    VLN2 = 0x00020000
                }

                CreateDWordField (CRS2, 0x54, MIN5)
                CreateDWordField (CRS2, 0x58, MAX5)
                CreateDWordField (CRS2, 0x60, LEN5)
                MIN5 = MBB /* \_SB_.S0D3.MBB_ */
                LEN5 = MBL /* \_SB_.S0D3.MBL_ */
                Local1 = LEN5 /* \_SB_.S0D3._CRS.LEN5 */
                MAX5 = (MIN5 + Local1--)
                CreateQWordField (CRS2, 0x72, MIN9)
                CreateQWordField (CRS2, 0x7A, MAX9)
                CreateQWordField (CRS2, 0x8A, LEN9)
                MIN9 = MABL /* \_SB_.S0D3.MABL */
                LEN9 = MALL /* \_SB_.S0D3.MALL */
                Local0 = LEN9 /* \_SB_.S0D3._CRS.LEN9 */
                MAX9 = (MIN9 + Local0--)
                Return (CRS2) /* \_SB_.S0D3.CRS2 */
            }

            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                Name (SUPP, Zero)
                Name (CTRL, Zero)
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.S0D3._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.S0D3._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    If (!PEHP)
                    {
                        CTRL &= 0x1E
                    }

                    If (!SHPC)
                    {
                        CTRL &= 0x1D
                    }

                    If (!PEPM)
                    {
                        CTRL &= 0x1B
                    }

                    If (!PEER)
                    {
                        CTRL &= 0x15
                    }

                    If (!PECS)
                    {
                        CTRL &= 0x0F
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.S0D3._OSC.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Device (D3A0)
            {
                Name (_ADR, 0x00010001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A1)
            {
                Name (_ADR, 0x00010002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A2)
            {
                Name (_ADR, 0x00010003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A3)
            {
                Name (_ADR, 0x00010004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A4)
            {
                Name (_ADR, 0x00010005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A5)
            {
                Name (_ADR, 0x00010006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A6)
            {
                Name (_ADR, 0x00010007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3A7)
            {
                Name (_ADR, 0x00020001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B0)
            {
                Name (_ADR, 0x00030001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B1)
            {
                Name (_ADR, 0x00030002)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B2)
            {
                Name (_ADR, 0x00030003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B3)
            {
                Name (_ADR, 0x00030004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B4)
            {
                Name (_ADR, 0x00030005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B5)
            {
                Name (_ADR, 0x00030006)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B6)
            {
                Name (_ADR, 0x00030007)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (D3B7)
            {
                Name (_ADR, 0x00040001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x08, 0x04))
                }
            }

            Device (S0D3)
            {
                Name (_ADR, 0x00070001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x14, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG68) /* \_SB_.AG68 */
                    }

                    Return (PG68) /* \_SB_.PG68 */
                }

                Device (D069)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (D06A)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (XHC0)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }
            }

            Device (BR6C)
            {
                Name (_ADR, 0x00080001)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AG6C) /* \_SB_.AG6C */
                    }

                    Return (PG6C) /* \_SB_.PG6C */
                }

                Device (D06D)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (SATA)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Name (B5EN, Zero)
                    Name (BA_5, Zero)
                    Name (SBAR, 0xF0B6F000)
                    Name (OSVR, Zero)
                    Name (SAD0, Zero)
                    Name (SAD3, Zero)
                    PowerResource (P0SA, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (SAD0) /* \_SB_.S0D3.BR6C.SATA.SAD0 */
                        }

                        Method (_ON, 0, NotSerialized)  // _ON_: Power On
                        {
                            DBG8 = 0xA1
                            SAD0 = One
                        }

                        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                        {
                            DBG8 = 0xA2
                            SAD0 = Zero
                        }
                    }

                    PowerResource (P3SA, 0x00, 0x0000)
                    {
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (SAD3) /* \_SB_.S0D3.BR6C.SATA.SAD3 */
                        }

                        Method (_ON, 0, NotSerialized)  // _ON_: Power On
                        {
                            DBG8 = 0xA4
                            SAD3 = One
                        }

                        Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                        {
                            DBG8 = 0xA5
                            SAD3 = Zero
                        }
                    }

                    OperationRegion (SATX, PCI_Config, Zero, 0x44)
                    Field (SATX, AnyAcc, NoLock, Preserve)
                    {
                        VIDI,   32, 
                        Offset (0x0A), 
                        STCL,   16, 
                        Offset (0x24), 
                        BA05,   32, 
                        Offset (0x40), 
                        WTEN,   1, 
                        Offset (0x42), 
                        DIS0,   1, 
                        DIS1,   1, 
                        DIS2,   1, 
                        DIS3,   1, 
                        DIS4,   1, 
                        DIS5,   1
                    }

                    Field (SATX, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x42), 
                        DISP,   6
                    }

                    Method (GBAA, 0, Serialized)
                    {
                        BA_5 = BA05 /* \_SB_.S0D3.BR6C.SATA.BA05 */
                        If (((BA_5 == Ones) || (STCL != 0x0101)))
                        {
                            B5EN = Zero
                            Return (SBAR) /* \_SB_.S0D3.BR6C.SATA.SBAR */
                        }
                        Else
                        {
                            B5EN = One
                            Return (BA_5) /* \_SB_.S0D3.BR6C.SATA.BA_5 */
                        }
                    }

                    OperationRegion (BAR5, SystemMemory, GBAA (), 0x1000)
                    Field (BAR5, AnyAcc, NoLock, Preserve)
                    {
                        NOPT,   5, 
                        Offset (0x0C), 
                        PTI0,   1, 
                        PTI1,   1, 
                        PTI2,   1, 
                        PTI3,   1, 
                        PTI4,   1, 
                        PTI5,   1, 
                        PTI6,   1, 
                        PTI7,   1, 
                        Offset (0x118), 
                        CST0,   1, 
                        Offset (0x120), 
                            ,   7, 
                        BSY0,   1, 
                        Offset (0x128), 
                        DET0,   4, 
                        Offset (0x129), 
                        IPM0,   4, 
                        Offset (0x12C), 
                        DDI0,   4, 
                        Offset (0x198), 
                        CST1,   1, 
                        Offset (0x1A0), 
                            ,   7, 
                        BSY1,   1, 
                        Offset (0x1A8), 
                        DET1,   4, 
                        Offset (0x1A9), 
                        IPM1,   4, 
                        Offset (0x1AC), 
                        DDI1,   4, 
                        Offset (0x218), 
                        CST2,   1, 
                        Offset (0x220), 
                            ,   7, 
                        BSY2,   1, 
                        Offset (0x228), 
                        DET2,   4, 
                        Offset (0x229), 
                        IPM2,   4, 
                        Offset (0x22C), 
                        DDI2,   4, 
                        Offset (0x298), 
                        CST3,   1, 
                        Offset (0x2A0), 
                            ,   7, 
                        BSY3,   1, 
                        Offset (0x2A8), 
                        DET3,   4, 
                        Offset (0x2A9), 
                        IPM3,   4, 
                        Offset (0x2AC), 
                        DDI3,   4, 
                        Offset (0x318), 
                        CST4,   1, 
                        Offset (0x320), 
                            ,   7, 
                        BSY4,   1, 
                        Offset (0x328), 
                        DET4,   4, 
                        Offset (0x329), 
                        IPM4,   4, 
                        Offset (0x32C), 
                        DDI4,   4, 
                        Offset (0x398), 
                        CST5,   1, 
                        Offset (0x3A0), 
                            ,   7, 
                        BSY5,   1, 
                        Offset (0x3A8), 
                        DET5,   4, 
                        Offset (0x3A9), 
                        IPM5,   4, 
                        Offset (0x3AC), 
                        DDI5,   4
                    }

                    Field (BAR5, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x0C), 
                        PTI,    6
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        GBAA ()
                    }

                    Device (PRID)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Name (SPTM, Buffer (0x14)
                        {
                            /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0010 */  0x1F, 0x00, 0x00, 0x00                           // ....
                        })
                        Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                        {
                            Return (SPTM) /* \_SB_.S0D3.BR6C.SATA.PRID.SPTM */
                        }

                        Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                        {
                            SPTM = Arg0
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((OSVR >= 0x0C) || (OSVR == Zero)) && B5EN))
                            {
                                If (IPM2)
                                {
                                    Local0 = 0x32
                                    While (((BSY2 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Device (P_D0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET0 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Name (S12P, Zero)
                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY0 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }

                        Device (P_D1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET2 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Name (S12P, Zero)
                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY2 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }
                    }

                    Device (SECD)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Name (SPTM, Buffer (0x14)
                        {
                            /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  // x.......
                            /* 0010 */  0x1F, 0x00, 0x00, 0x00                           // ....
                        })
                        Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                        {
                            Return (SPTM) /* \_SB_.S0D3.BR6C.SATA.SECD.SPTM */
                        }

                        Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                        {
                            SPTM = Arg0
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((OSVR >= 0x0C) || (OSVR == Zero)) && B5EN))
                            {
                                If (IPM1)
                                {
                                    Local0 = 0x32
                                    While (((BSY1 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }

                                If (IPM3)
                                {
                                    Local0 = 0x32
                                    While (((BSY3 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Device (S_D0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET1 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY1 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }

                        Device (S_D1)
                        {
                            Name (_ADR, One)  // _ADR: Address
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                GBAA ()
                                If ((B5EN == Zero))
                                {
                                    Return (Zero)
                                }

                                If ((DET3 == 0x03))
                                {
                                    Return (0x0F)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                            {
                                GBAA ()
                                If ((((OSVR < 0x0C) && (OSVR != Zero)) && B5EN))
                                {
                                    Local0 = 0x32
                                    While (((BSY3 == One) && Local0))
                                    {
                                        Sleep (0xFA)
                                        Local0--
                                    }
                                }
                            }

                            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                            {
                                Local0 = Buffer (0x07)
                                    {
                                         0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         // .F.....
                                    }
                                Return (Local0)
                            }
                        }
                    }

                    Method (ENP, 2, NotSerialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            DIS0 = ~Arg1
                        }
                        ElseIf ((Arg0 == One))
                        {
                            DIS1 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            DIS2 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            DIS3 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x04))
                        {
                            DIS4 = ~Arg1
                        }
                        ElseIf ((Arg0 == 0x05))
                        {
                            DIS5 = ~Arg1
                        }

                        WTEN = One
                        If ((Arg0 == Zero))
                        {
                            PTI0 = Arg1
                        }
                        ElseIf ((Arg0 == One))
                        {
                            PTI1 = Arg1
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            PTI2 = Arg1
                        }
                        ElseIf ((Arg0 == 0x03))
                        {
                            PTI3 = Arg1
                        }
                        ElseIf ((Arg0 == 0x04))
                        {
                            PTI4 = Arg1
                        }
                        ElseIf ((Arg0 == 0x05))
                        {
                            PTI5 = Arg1
                        }

                        If ((DISP == 0x3F))
                        {
                            PTI0 = One
                        }
                        ElseIf ((DIS0 && ((DISP & 0x3E) ^ 0x3E)))
                        {
                            PTI0 = Zero
                        }

                        Local0 = PTI /* \_SB_.S0D3.BR6C.SATA.PTI_ */
                        Local1 = Zero
                        While (Local0)
                        {
                            If ((Local0 & One))
                            {
                                Local1++
                            }

                            Local0 >>= One
                        }

                        NOPT = Local1--
                        WTEN = Zero
                    }
                }

                Device (D06F)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (D070)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (D071)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (D072)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (D073)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.D0A1, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A2, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A3, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A4, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A5, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A6, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A7, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B0, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B1, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B2, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B3, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B4, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B5, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B6, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0B7, 0x02) // Device Wake
            Notify (\_SB.PCI0.D0A0, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A0, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A1, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A2, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A3, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A4, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A5, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A6, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1A7, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B0, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B1, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B2, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B3, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B4, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B5, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B6, 0x02) // Device Wake
            Notify (\_SB.S0D1.D1B7, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A0, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A1, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A2, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A3, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A4, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A5, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A6, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2A7, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B0, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B1, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B2, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B3, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B4, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B5, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B6, 0x02) // Device Wake
            Notify (\_SB.S0D2.D2B7, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A0, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A1, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A2, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A3, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A4, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A5, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A6, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3A7, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B0, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B1, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B2, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B3, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B4, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B5, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B6, 0x02) // Device Wake
            Notify (\_SB.S0D3.D3B7, 0x02) // Device Wake
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        Method (_L19, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.D0C0, 0x02) // Device Wake
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        Method (_L14, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.S0D1.D1C0, 0x02) // Device Wake
            Notify (\_SB.S0D2.S0D2, 0x02) // Device Wake
            Notify (\_SB.S0D3.S0D3, 0x02) // Device Wake
            Notify (\_SB.PWRB, 0x02) // Device Wake
        }
    }

    Scope (_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Name (_UID, 0xAA)  // _UID: Unique ID
            Name (_STA, 0x0B)  // _STA: Status
        }
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x04)  // _S3_: S3 System State
    {
        0x03, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x04, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x05, 
        Zero, 
        Zero, 
        Zero
    })
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (Arg0)
        {
            LEDS (Arg0)
            \_SB.TPM.TPTS (Arg0)
            SPTS (Arg0)
            \_SB.PCI0.SBRG.SIO1.SIOS (Arg0)
            \_SB.PCI0.GPTS (Arg0)
            \_SB.PCI0.NPTS (Arg0)
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        DBG8 = (Arg0 << 0x04)
        \_SB.PCI0.NWAK (Arg0)
        \_SB.PCI0.GWAK (Arg0)
        \_SB.PCI0.SBRG.SIO1.SIOW (Arg0)
        DBG8 = (Arg0 << 0x04)
        SWAK (Arg0)
        LEDW (Arg0)
        Return (WAKP) /* \WAKP */
    }

    Scope (_SB.PCI0)
    {
        Method (BN00, 0, NotSerialized)
        {
            Return (BRB) /* \_SB_.PCI0.BRB_ */
        }

        Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
        {
            Return (Zero)
        }
    }

    Scope (_SB.S0D1)
    {
        Method (BN01, 0, NotSerialized)
        {
            Return (BRB) /* \_SB_.S0D1.BRB_ */
        }

        Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
        {
            Return (One)
        }
    }

    Scope (_SB.S0D2)
    {
        Method (BN02, 0, NotSerialized)
        {
            Return (BRB) /* \_SB_.S0D2.BRB_ */
        }

        Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
        {
            Return (0x02)
        }
    }

    Scope (_SB.S0D3)
    {
        Method (BN03, 0, NotSerialized)
        {
            Return (BRB) /* \_SB_.S0D3.BRB_ */
        }

        Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
        {
            Return (0x03)
        }
    }

    Scope (_SB)
    {
        OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
        Field (PIRQ, ByteAcc, NoLock, Preserve)
        {
            PIDX,   8, 
            PDAT,   8
        }

        IndexField (PIDX, PDAT, ByteAcc, NoLock, Preserve)
        {
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8, 
            PIRE,   8, 
            PIRF,   8, 
            PIRG,   8, 
            PIRH,   8, 
            Offset (0x0C), 
            SIRA,   8, 
            SIRB,   8, 
            SIRC,   8, 
            SIRD,   8, 
            PIRS,   8, 
            Offset (0x13), 
            HDAD,   8, 
            Offset (0x17), 
            SDCL,   8, 
            Offset (0x1A), 
            SDIO,   8, 
            Offset (0x30), 
            USB1,   8, 
            Offset (0x34), 
            USB3,   8, 
            Offset (0x41), 
            SATA,   8, 
            Offset (0x62), 
            GIOC,   8, 
            Offset (0x70), 
            I2C0,   8, 
            I2C1,   8, 
            I2C2,   8, 
            I2C3,   8, 
            URT0,   8, 
            URT1,   8, 
            Offset (0x80), 
            AIRA,   8, 
            AIRB,   8, 
            AIRC,   8, 
            AIRD,   8, 
            AIRE,   8, 
            AIRF,   8, 
            AIRG,   8, 
            AIRH,   8
        }

        OperationRegion (KBDD, SystemIO, 0x64, One)
        Field (KBDD, ByteAcc, NoLock, Preserve)
        {
            IO64,   8
        }

        Method (DSPI, 0, NotSerialized)
        {
            INTA (0x1F)
            INTB (0x1F)
            INTC (0x1F)
            INTD (0x1F)
            Local1 = IO64 /* \_SB_.IO64 */
            PIRE = 0x1F
            PIRF = 0x1F
            PIRG = 0x1F
            PIRH = 0x1F
            Local1 = IO64 /* \_SB_.IO64 */
            AIRA = 0x10
            AIRB = 0x11
            AIRC = 0x12
            AIRD = 0x13
            AIRE = 0x14
            AIRF = 0x15
            AIRG = 0x16
            AIRH = 0x17
        }

        Method (INTA, 1, NotSerialized)
        {
            PIRA = Arg0
            HDAD = Arg0
        }

        Method (INTB, 1, NotSerialized)
        {
            PIRB = Arg0
        }

        Method (INTC, 1, NotSerialized)
        {
            PIRC = Arg0
            USB1 = Arg0
            USB3 = Arg0
        }

        Method (INTD, 1, NotSerialized)
        {
            PIRD = Arg0
            SATA = Arg0
        }

        Name (BUFA, Buffer (0x06)
        {
             0x23, 0x00, 0x80, 0x18, 0x79, 0x00               // #...y.
        })
        Name (IPRA, Buffer (0x06)
        {
             0x23, 0x20, 0x0C, 0x18, 0x79, 0x00               // # ..y.
        })
        Name (IPRB, Buffer (0x06)
        {
             0x23, 0x20, 0x0C, 0x18, 0x79, 0x00               // # ..y.
        })
        Name (IPRC, Buffer (0x06)
        {
             0x23, 0x20, 0x0C, 0x18, 0x79, 0x00               // # ..y.
        })
        Name (IPRD, Buffer (0x06)
        {
             0x23, 0x20, 0x0C, 0x18, 0x79, 0x00               // # ..y.
        })
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRA)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSA) /* \_SB_.PRSA */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTA (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRA) /* \_SB_.PIRA */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                INTA (Local0)
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRB)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSB) /* \_SB_.PRSB */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTB (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRB) /* \_SB_.PIRB */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                INTB (Local0)
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRC)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSC) /* \_SB_.PRSC */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTC (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRC) /* \_SB_.PIRC */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                INTC (Local0)
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRD)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSD) /* \_SB_.PRSD */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTD (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRD) /* \_SB_.PIRD */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                INTD (Local0)
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRE)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSE) /* \_SB_.PRSE */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRE = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRE) /* \_SB_.PIRE */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (PIRE, Local0)
                Local0--
                PIRE = Local0
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRF)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSF) /* \_SB_.PRSF */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRF = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRF) /* \_SB_.PIRF */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRF = Local0
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRG)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSG) /* \_SB_.PRSG */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRG = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRG) /* \_SB_.PIRG */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRG = Local0
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRH)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRSH) /* \_SB_.PRSH */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRH = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRH) /* \_SB_.PIRH */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRH = Local0
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            OSFL ()
            DSPI ()
            NAPE ()
        }
    }

    Name (TSOS, 0x75)
    If (CondRefOf (\_OSI))
    {
        If (_OSI ("Windows 2009"))
        {
            TSOS = 0x50
        }

        If (_OSI ("Windows 2015"))
        {
            TSOS = 0x70
        }
    }

    Scope (_SB)
    {
        OperationRegion (ECMC, SystemIO, 0x72, 0x02)
        Field (ECMC, AnyAcc, NoLock, Preserve)
        {
            ECMI,   8, 
            ECMD,   8
        }

        IndexField (ECMI, ECMD, ByteAcc, NoLock, Preserve)
        {
            Offset (0x08), 
            FRTB,   32
        }

        OperationRegion (FRTP, SystemMemory, FRTB, 0x0100)
        Field (FRTP, AnyAcc, NoLock, Preserve)
        {
            PEBA,   32, 
                ,   5, 
            IC0E,   1, 
            IC1E,   1, 
            IC2E,   1, 
            IC3E,   1, 
            IC4E,   1, 
            IC5E,   1, 
            UT0E,   1, 
            UT1E,   1, 
                ,   1, 
                ,   1, 
            ST_E,   1, 
            UT2E,   1, 
                ,   1, 
            EMMD,   2, 
                ,   3, 
            XHCE,   1, 
                ,   1, 
                ,   1, 
            UT3E,   1, 
            ESPI,   1, 
            EMME,   1, 
            Offset (0x08), 
            PCEF,   1, 
                ,   4, 
            IC0D,   1, 
            IC1D,   1, 
            IC2D,   1, 
            IC3D,   1, 
            IC4D,   1, 
            IC5D,   1, 
            UT0D,   1, 
            UT1D,   1, 
                ,   1, 
                ,   1, 
            ST_D,   1, 
            UT2D,   1, 
                ,   1, 
            EHCD,   1, 
                ,   4, 
            XHCD,   1, 
            SD_D,   1, 
                ,   1, 
            UT3D,   1, 
                ,   1, 
            EMD3,   1, 
                ,   2, 
            S03D,   1, 
            FW00,   16, 
            FW01,   32, 
            FW02,   16, 
            FW03,   32, 
            SDS0,   8, 
            SDS1,   8, 
            CZFG,   1, 
            Offset (0x20), 
            SD10,   32, 
            EH10,   32, 
            XH10,   32, 
            STBA,   32
        }

        OperationRegion (FCFG, SystemMemory, PEBA, 0x01000000)
        Field (FCFG, DWordAcc, NoLock, Preserve)
        {
            Offset (0xA3044), 
            IPDE,   32, 
            IMPE,   32, 
            Offset (0xA3078), 
                ,   2, 
            LDQ0,   1, 
            Offset (0xA30CB), 
                ,   7, 
            AUSS,   1
        }

        OperationRegion (IOMX, SystemMemory, 0xFED80D00, 0x0100)
        Field (IOMX, AnyAcc, NoLock, Preserve)
        {
            Offset (0x15), 
            IM15,   8, 
            IM16,   8, 
            Offset (0x1F), 
            IM1F,   8, 
            IM20,   8, 
            Offset (0x44), 
            IM44,   8, 
            Offset (0x46), 
            IM46,   8, 
            Offset (0x4A), 
            IM4A,   8, 
            IM4B,   8, 
            Offset (0x57), 
            IM57,   8, 
            IM58,   8, 
            Offset (0x68), 
            IM68,   8, 
            IM69,   8, 
            IM6A,   8, 
            IM6B,   8, 
            Offset (0x6D), 
            IM6D,   8
        }

        OperationRegion (FACR, SystemMemory, 0xFED81E00, 0x0100)
        Field (FACR, AnyAcc, NoLock, Preserve)
        {
            Offset (0x80), 
                ,   28, 
            RD28,   1, 
                ,   1, 
            RQTY,   1, 
            Offset (0x84), 
                ,   28, 
            SD28,   1, 
                ,   1, 
            Offset (0xA0), 
            PG1A,   1
        }

        OperationRegion (EMMX, SystemMemory, 0xFEDD5800, 0x0130)
        Field (EMMX, AnyAcc, NoLock, Preserve)
        {
            Offset (0xD0), 
                ,   17, 
            FC18,   1, 
            FC33,   1, 
                ,   7, 
            CD_T,   1, 
            WP_T,   1
        }

        OperationRegion (EMMB, SystemMemory, 0xFEDD5800, 0x0130)
        Field (EMMB, AnyAcc, NoLock, Preserve)
        {
            Offset (0xA4), 
            E0A4,   32, 
            E0A8,   32, 
            Offset (0xB0), 
            E0B0,   32, 
            Offset (0xD0), 
            E0D0,   32, 
            Offset (0x116), 
            E116,   32
        }

        Name (SVBF, Buffer (0x0100)
        {
             0x00                                             // .
        })
        CreateDWordField (SVBF, Zero, S0A4)
        CreateDWordField (SVBF, 0x04, S0A8)
        CreateDWordField (SVBF, 0x08, S0B0)
        CreateDWordField (SVBF, 0x0C, S0D0)
        CreateDWordField (SVBF, 0x10, S116)
        Method (SECR, 0, Serialized)
        {
            S116 = E116 /* \_SB_.E116 */
            RQTY = Zero
            RD28 = One
            Local0 = SD28 /* \_SB_.SD28 */
            While (Local0)
            {
                Local0 = SD28 /* \_SB_.SD28 */
            }
        }

        Method (RECR, 0, Serialized)
        {
            E116 = S116 /* \_SB_.S116 */
        }

        OperationRegion (LUIE, SystemMemory, 0xFEDC0020, 0x04)
        Field (LUIE, AnyAcc, NoLock, Preserve)
        {
            IER0,   1, 
            IER1,   1, 
            IER2,   1, 
            IER3,   1, 
            UOL0,   1, 
            UOL1,   1, 
            UOL2,   1, 
            UOL3,   1, 
            WUR0,   2, 
            WUR1,   2, 
            WUR2,   2, 
            WUR3,   2
        }

        Method (FRUI, 2, Serialized)
        {
            If ((Arg0 == Zero))
            {
                Arg1 = IUA0 /* \_SB_.IUA0 */
            }

            If ((Arg0 == One))
            {
                Arg1 = IUA1 /* \_SB_.IUA1 */
            }

            If ((Arg0 == 0x02))
            {
                Arg1 = IUA2 /* \_SB_.IUA2 */
            }

            If ((Arg0 == 0x03))
            {
                Arg1 = IUA3 /* \_SB_.IUA3 */
            }
        }

        Method (SRAD, 2, Serialized)
        {
            Local0 = (Arg0 << One)
            Local0 += 0xFED81E40
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            ADIS = One
            ADSR = Zero
            Stall (Arg1)
            ADSR = One
            ADIS = Zero
            Stall (Arg1)
        }

        Method (DSAD, 2, Serialized)
        {
            Local0 = (Arg0 << One)
            Local0 += 0xFED81E40
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            If ((Arg0 != ADTD))
            {
                If ((Arg1 == Zero))
                {
                    ADTD = Zero
                    ADPD = One
                    Local0 = ADDS /* \_SB_.DSAD.ADDS */
                    While ((Local0 != 0x07))
                    {
                        Local0 = ADDS /* \_SB_.DSAD.ADDS */
                    }
                }

                If ((Arg1 == 0x03))
                {
                    ADPD = Zero
                    Local0 = ADDS /* \_SB_.DSAD.ADDS */
                    While ((Local0 != Zero))
                    {
                        Local0 = ADDS /* \_SB_.DSAD.ADDS */
                    }

                    ADTD = 0x03
                }
            }
        }

        Method (HSAD, 2, Serialized)
        {
            Local3 = (One << Arg0)
            Local0 = (Arg0 << One)
            Local0 += 0xFED81E40
            OperationRegion (ADCR, SystemMemory, Local0, 0x02)
            Field (ADCR, ByteAcc, NoLock, Preserve)
            {
                ADTD,   2, 
                ADPS,   1, 
                ADPD,   1, 
                ADSO,   1, 
                ADSC,   1, 
                ADSR,   1, 
                ADIS,   1, 
                ADDS,   3
            }

            If ((Arg1 != ADTD))
            {
                If ((Arg1 == Zero))
                {
                    PG1A = One
                    ADTD = Zero
                    ADPD = One
                    Local0 = ADDS /* \_SB_.HSAD.ADDS */
                    While ((Local0 != 0x07))
                    {
                        Local0 = ADDS /* \_SB_.HSAD.ADDS */
                    }

                    RQTY = One
                    RD28 = One
                    Local0 = SD28 /* \_SB_.SD28 */
                    While (!Local0)
                    {
                        Local0 = SD28 /* \_SB_.SD28 */
                    }
                }

                If ((Arg1 == 0x03))
                {
                    RQTY = Zero
                    RD28 = One
                    Local0 = SD28 /* \_SB_.SD28 */
                    While (Local0)
                    {
                        Local0 = SD28 /* \_SB_.SD28 */
                    }

                    ADPD = Zero
                    Local0 = ADDS /* \_SB_.HSAD.ADDS */
                    While ((Local0 != Zero))
                    {
                        Local0 = ADDS /* \_SB_.HSAD.ADDS */
                    }

                    ADTD = 0x03
                    PG1A = Zero
                }
            }
        }

        OperationRegion (FPIC, SystemIO, 0x0C00, 0x02)
        Field (ECMC, AnyAcc, NoLock, Preserve)
        {
            FPII,   8, 
            FPID,   8
        }

        IndexField (FPII, FPID, ByteAcc, NoLock, Preserve)
        {
            Offset (0xF4), 
            IUA0,   8, 
            IUA1,   8, 
            Offset (0xF8), 
            IUA2,   8, 
            IUA3,   8
        }

        Device (GPIO)
        {
            Name (_HID, "AMDI0030")  // _HID: Hardware ID
            Name (_CID, "AMDI0030")  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, Buffer (0x17)
                {
                    /* 0000 */  0x89, 0x06, 0x00, 0x0D, 0x01, 0x07, 0x00, 0x00,  // ........
                    /* 0008 */  0x00, 0x86, 0x09, 0x00, 0x01, 0x00, 0x15, 0xD8,  // ........
                    /* 0010 */  0xFE, 0x00, 0x04, 0x00, 0x00, 0x79, 0x00         // .....y.
                })
                Return (RBUF) /* \_SB_.GPIO._CRS.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (FUR0)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, Buffer (0x1E)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x08, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0x90, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                /* 0010 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x70, 0xDC, 0xFE,  // .....p..
                /* 0018 */  0x00, 0x10, 0x00, 0x00, 0x79, 0x00               // ....y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((UT0E == One))
                    {
                        If (IER0)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (FUR1)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CRS, Buffer (0x1E)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x10, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0xA0, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                /* 0010 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x80, 0xDC, 0xFE,  // ........
                /* 0018 */  0x00, 0x10, 0x00, 0x00, 0x79, 0x00               // ....y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((UT1E == One))
                    {
                        If (UOL1)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (FUR2)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CRS, Buffer (0x1E)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x08, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0xE0, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                /* 0010 */  0x86, 0x09, 0x00, 0x01, 0x00, 0xC0, 0xDC, 0xFE,  // ........
                /* 0018 */  0x00, 0x10, 0x00, 0x00, 0x79, 0x00               // ....y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((UT2E == One))
                    {
                        If (UOL2)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (FUR3)
        {
            Name (_HID, "AMDI0020")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CRS, Buffer (0x1E)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x10, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0xF0, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                /* 0010 */  0x86, 0x09, 0x00, 0x01, 0x00, 0xD0, 0xDC, 0xFE,  // ........
                /* 0018 */  0x00, 0x10, 0x00, 0x00, 0x79, 0x00               // ....y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((UT3E == One))
                    {
                        If (UOL3)
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Device (I2CA)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x00, 0x04, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0x20, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // . ......
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC0E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x05, 0xC8)
            }
        }

        Device (I2CB)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x00, 0x08, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0x30, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .0......
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC1E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x06, 0xC8)
            }
        }

        Device (I2CC)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x10, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0x40, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .@......
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC2E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x07, 0xC8)
            }
        }

        Device (I2CD)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x40, 0x00, 0x01, 0x86, 0x09, 0x00, 0x01,  // #@......
                /* 0008 */  0x00, 0x50, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .P......
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC3E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x08, 0xC8)
            }
        }

        Device (I2CE)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x00, 0x40, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.@.....
                /* 0008 */  0x00, 0x60, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .`......
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC4E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x09, 0xC8)
            }
        }

        Device (I2CF)
        {
            Name (_HID, "AMDI0010")  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Name (_CRS, Buffer (0x12)  // _CRS: Current Resource Settings
            {
                /* 0000 */  0x23, 0x00, 0x80, 0x01, 0x86, 0x09, 0x00, 0x01,  // #.......
                /* 0008 */  0x00, 0xB0, 0xDC, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
                /* 0010 */  0x79, 0x00                                       // y.
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If ((IC5E == One))
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (RSET, 0, NotSerialized)
            {
                SRAD (0x0A, 0xC8)
            }
        }

        Method (EPIN, 0, NotSerialized)
        {
            IPDE = Zero
            IMPE = Zero
            IM15 = One
            IM16 = One
            IM20 = One
            IM44 = One
            IM46 = One
            IM68 = One
            IM69 = One
            IM6A = One
            IM6B = One
            IM4A = One
            IM58 = One
            IM4B = One
            IM57 = One
            IM6D = One
            IM1F = One
            SECR ()
        }

        Name (NCRS, Buffer (0x12)
        {
            /* 0000 */  0x23, 0x20, 0x00, 0x18, 0x86, 0x09, 0x00, 0x01,  // # ......
            /* 0008 */  0x00, 0x50, 0xDD, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .P......
            /* 0010 */  0x79, 0x00                                       // y.
        })
        Name (DCRS, Buffer (0x58)
        {
            /* 0000 */  0x23, 0x20, 0x00, 0x18, 0x86, 0x09, 0x00, 0x01,  // # ......
            /* 0008 */  0x00, 0x50, 0xDD, 0xFE, 0x00, 0x10, 0x00, 0x00,  // .P......
            /* 0010 */  0x8C, 0x20, 0x00, 0x01, 0x00, 0x01, 0x00, 0x1D,  // . ......
            /* 0018 */  0x00, 0x01, 0x00, 0x00, 0xB8, 0x0B, 0x17, 0x00,  // ........
            /* 0020 */  0x00, 0x19, 0x00, 0x23, 0x00, 0x00, 0x00, 0x44,  // ...#...D
            /* 0028 */  0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x47, 0x50,  // .\_SB.GP
            /* 0030 */  0x49, 0x4F, 0x00, 0x8C, 0x20, 0x00, 0x01, 0x01,  // IO.. ...
            /* 0038 */  0x01, 0x00, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00,  // ........
            /* 0040 */  0x00, 0x17, 0x00, 0x00, 0x19, 0x00, 0x23, 0x00,  // ......#.
            /* 0048 */  0x00, 0x00, 0x44, 0x00, 0x5C, 0x5F, 0x53, 0x42,  // ..D.\_SB
            /* 0050 */  0x2E, 0x47, 0x50, 0x49, 0x4F, 0x00, 0x79, 0x00   // .GPIO.y.
        })
        Name (AHID, "AMDI0040")
        Name (ACID, "AMDI0040")
        Name (SHID, 0x400DD041)
        Name (SCID, "PCICC_080501")
        Device (EMM0)
        {
            Method (_HID, 0, Serialized)  // _HID: Hardware ID
            {
                If (EMMD)
                {
                    Return (SHID) /* \_SB_.SHID */
                }
                Else
                {
                    Return (AHID) /* \_SB_.AHID */
                }
            }

            Method (_CID, 0, Serialized)  // _CID: Compatible ID
            {
                If (EMMD)
                {
                    Return (SCID) /* \_SB_.SCID */
                }
                Else
                {
                    Return (ACID) /* \_SB_.ACID */
                }
            }

            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                If (EMD3)
                {
                    Return (DCRS) /* \_SB_.DCRS */
                }
                Else
                {
                    Return (NCRS) /* \_SB_.NCRS */
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((TSOS >= 0x70))
                {
                    If (EMME)
                    {
                        Return (0x0F)
                    }

                    Return (Zero)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If (EMME)
                {
                    EPIN ()
                }
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                If ((EMD3 && EMME))
                {
                    Return (0x04)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                If ((EMD3 && EMME))
                {
                    HSAD (0x1C, Zero)
                    RECR ()
                }
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If ((EMD3 && EMME))
                {
                    HSAD (0x1C, 0x03)
                }
            }
        }

        Device (UAR1)
        {
            Name (_HID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM1")  // _DDN: DOS Device Name
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER0)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, Buffer (0x0D)
                {
                    /* 0000 */  0x47, 0x01, 0xE8, 0x02, 0xE8, 0x02, 0x01, 0x08,  // G.......
                    /* 0008 */  0x22, 0x08, 0x00, 0x79, 0x00                     // "..y.
                })
                CreateByteField (BUF0, 0x02, IOLO)
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, 0x04, IORL)
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, 0x09, IRQL)
                FRUI (WUR0, IRQL)
                Return (BUF0) /* \_SB_.UAR1._CRS.BUF0 */
            }
        }

        Device (UAR2)
        {
            Name (_HID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM2")  // _DDN: DOS Device Name
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER1)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, Buffer (0x0D)
                {
                    /* 0000 */  0x47, 0x01, 0xF8, 0x02, 0xF8, 0x02, 0x01, 0x08,  // G.......
                    /* 0008 */  0x22, 0x10, 0x00, 0x79, 0x00                     // "..y.
                })
                CreateByteField (BUF0, 0x02, IOLO)
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, 0x04, IORL)
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, 0x09, IRQL)
                FRUI (WUR1, IRQL)
                Return (BUF0) /* \_SB_.UAR2._CRS.BUF0 */
            }
        }

        Device (UAR3)
        {
            Name (_HID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM3")  // _DDN: DOS Device Name
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER2)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, Buffer (0x0D)
                {
                    /* 0000 */  0x47, 0x01, 0xE8, 0x03, 0xE8, 0x03, 0x01, 0x08,  // G.......
                    /* 0008 */  0x22, 0x08, 0x00, 0x79, 0x00                     // "..y.
                })
                CreateByteField (BUF0, 0x02, IOLO)
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, 0x04, IORL)
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, 0x09, IRQL)
                FRUI (WUR2, IRQL)
                Return (BUF0) /* \_SB_.UAR3._CRS.BUF0 */
            }
        }

        Device (UAR4)
        {
            Name (_HID, EisaId ("PNP0500") /* Standard PC COM Serial Port */)  // _HID: Hardware ID
            Name (_DDN, "COM4")  // _DDN: DOS Device Name
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (IER3)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BUF0, Buffer (0x0D)
                {
                    /* 0000 */  0x47, 0x01, 0xF8, 0x03, 0xF8, 0x03, 0x01, 0x08,  // G.......
                    /* 0008 */  0x22, 0x10, 0x00, 0x79, 0x00                     // "..y.
                })
                CreateByteField (BUF0, 0x02, IOLO)
                CreateByteField (BUF0, 0x03, IOHI)
                CreateByteField (BUF0, 0x04, IORL)
                CreateByteField (BUF0, 0x05, IORH)
                CreateWordField (BUF0, 0x09, IRQL)
                FRUI (WUR3, IRQL)
                Return (BUF0) /* \_SB_.UAR4._CRS.BUF0 */
            }
        }
    }

    Device (_SB.TPM)
    {
        Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
        {
            If (TCMF)
            {
                Return (0x01013469)
            }
            ElseIf ((TTDP == Zero))
            {
                Return (0x310CD041)
            }
            Else
            {
                Return ("MSFT0101")
            }
        }

        Method (_STR, 0, NotSerialized)  // _STR: Description String
        {
            If ((TTDP == Zero))
            {
                Return (Unicode ("TPM 1.2 Device"))
            }
            Else
            {
                Return (Unicode ("TPM 2.0 Device"))
            }
        }

        Name (_UID, One)  // _UID: Unique ID
        Name (CRST, Buffer (0x1A)
        {
            /* 0000 */  0x86, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
            /* 0008 */  0x00, 0x10, 0x00, 0x00, 0x86, 0x09, 0x00, 0x00,  // ........
            /* 0010 */  0x00, 0x00, 0xD7, 0xFE, 0x00, 0x10, 0x00, 0x00,  // ........
            /* 0018 */  0x79, 0x00                                       // y.
        })
        Name (CRSD, Buffer (0x0E)
        {
            /* 0000 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0xD4, 0xFE,  // ........
            /* 0008 */  0x00, 0x50, 0x00, 0x00, 0x79, 0x00               // .P..y.
        })
        Name (CRSI, Buffer (0x0E)
        {
            /* 0000 */  0x86, 0x09, 0x00, 0x01, 0x00, 0x00, 0xD4, 0xFE,  // ........
            /* 0008 */  0x00, 0x50, 0x00, 0x00, 0x79, 0x00               // .P..y.
        })
        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            If ((AMDT == One))
            {
                CreateDWordField (CRST, 0x04, MTFB)
                CreateDWordField (CRST, 0x08, LTFB)
                MTFB = TPMB /* \TPMB */
                LTFB = 0x4000
                CreateDWordField (CRST, 0x10, MTFC)
                CreateDWordField (CRST, 0x14, LTFC)
                MTFC = TPMC /* \TPMC */
                LTFC = 0x1000
                Return (CRST) /* \_SB_.TPM_.CRST */
            }
            Else
            {
                If ((DTPT == One))
                {
                    CreateDWordField (CRSD, 0x04, MTFE)
                    CreateDWordField (CRSD, 0x08, LTFE)
                    MTFE = 0xFED40000
                    LTFE = 0x5000
                    Return (CRSD) /* \_SB_.TPM_.CRSD */
                }
                ElseIf ((TTPF == One))
                {
                    CreateDWordField (CRSI, 0x04, MTFD)
                    CreateDWordField (CRSI, 0x08, LTFD)
                    MTFD = 0xFED40000
                    LTFD = 0x5000
                    Return (CRSI) /* \_SB_.TPM_.CRSI */
                }
                ElseIf ((TTPF == Zero))
                {
                    CreateDWordField (CRSI, 0x04, MTFF)
                    MTFF = TPMM /* \TPMM */
                    Return (CRSI) /* \_SB_.TPM_.CRSI */
                }

                MTFE = Zero
                LTFE = Zero
                Return (CRSI) /* \_SB_.TPM_.CRSI */
            }

            Return (CRSI) /* \_SB_.TPM_.CRSI */
        }

        OperationRegion (TMMB, SystemMemory, 0xFED40000, 0x5000)
        Field (TMMB, ByteAcc, Lock, Preserve)
        {
            Offset (0x04), 
            LCST,   32, 
            Offset (0x40), 
            CREQ,   32, 
            CSTS,   32, 
            Offset (0x4C), 
            SCMD,   32
        }

        OperationRegion (CRBD, SystemMemory, TPMM, 0x48)
        Field (CRBD, AnyAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            HERR,   32, 
            Offset (0x40), 
            HCMD,   32, 
            HSTS,   32
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If ((TTDP == Zero))
            {
                If (TPMF)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }
            ElseIf ((TTDP == One))
            {
                If (TPMF)
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Return (Zero)
        }

        Method (STRT, 3, Serialized)
        {
            OperationRegion (TPMR, SystemMemory, FTPM, 0x1000)
            Field (TPMR, AnyAcc, NoLock, Preserve)
            {
                Offset (0x04), 
                FERR,   32, 
                Offset (0x0C), 
                BEGN,   32
            }

            Name (TIMR, Zero)
            If ((ToInteger (Arg0) != Zero)){}
            Switch (ToInteger (Arg1))
            {
                Case (Zero)
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }
                Case (One)
                {
                    TIMR = Zero
                    If ((AMDT == One))
                    {
                        While (((BEGN == One) && (TIMR < 0x0200)))
                        {
                            If ((BEGN == One))
                            {
                                Sleep (One)
                                TIMR++
                            }
                        }
                    }
                    ElseIf ((((HSTS & 0x02) | (HSTS & One)
                        ) == 0x03))
                    {
                        HCMD = One
                    }
                    Else
                    {
                        FERR = One
                        BEGN = Zero
                    }

                    Return (Zero)
                }

            }

            Return (One)
        }

        Method (CRYF, 3, Serialized)
        {
            If ((ToInteger (Arg0) != One)){}
            Switch (ToInteger (Arg1))
            {
                Case (Zero)
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }
                Case (One)
                {
                    Name (TPMV, Package (0x02)
                    {
                        One, 
                        Package (0x02)
                        {
                            One, 
                            0x20
                        }
                    })
                    If ((_STA () == Zero))
                    {
                        Return (Package (0x01)
                        {
                            Zero
                        })
                    }

                    Return (TPMV) /* \_SB_.TPM_.CRYF.TPMV */
                }

            }

            Return (Buffer (One)
            {
                 0x00                                             // .
            })
        }
    }

    Scope (_SB.TPM)
    {
        OperationRegion (TSMI, SystemIO, SMIA, 0x02)
        Field (TSMI, WordAcc, NoLock, Preserve)
        {
            SMI,    16
        }

        OperationRegion (ATNV, SystemMemory, PPIM, PPIL)
        Field (ATNV, AnyAcc, NoLock, Preserve)
        {
            RQST,   32, 
            RCNT,   32, 
            ERRO,   32, 
            FLAG,   32, 
            MISC,   32, 
            OPTN,   32, 
            SRSP,   32
        }

        Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
        {
            If ((Arg0 == ToUUID ("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence Interface */))
            {
                Switch (ToInteger (Arg2))
                {
                    Case (Zero)
                    {
                        Return (Buffer (0x02)
                        {
                             0xFF, 0x01                                       // ..
                        })
                    }
                    Case (One)
                    {
                        If ((PPIV == Zero))
                        {
                            Return ("1.2")
                        }
                        Else
                        {
                            Return ("1.3")
                        }
                    }
                    Case (0x02)
                    {
                        RQST = DerefOf (Arg3 [Zero])
                        SRSP = Zero
                        FLAG = 0x02
                        TMF1 = OFST /* \OFST */
                        SRSP = Zero
                        SMI = TMF1 /* \TMF1 */
                        Return (SRSP) /* \_SB_.TPM_.SRSP */
                    }
                    Case (0x03)
                    {
                        Name (PPI1, Package (0x02)
                        {
                            Zero, 
                            Zero
                        })
                        PPI1 [One] = RQST /* \_SB_.TPM_.RQST */
                        Return (PPI1) /* \_SB_.TPM_._DSM.PPI1 */
                    }
                    Case (0x04)
                    {
                        Return (TRST) /* \TRST */
                    }
                    Case (0x05)
                    {
                        Name (PPI2, Package (0x03)
                        {
                            Zero, 
                            Zero, 
                            Zero
                        })
                        SRSP = Zero
                        FLAG = 0x05
                        SMI = OFST /* \OFST */
                        PPI2 [One] = RCNT /* \_SB_.TPM_.RCNT */
                        PPI2 [0x02] = ERRO /* \_SB_.TPM_.ERRO */
                        Return (PPI2) /* \_SB_.TPM_._DSM.PPI2 */
                    }
                    Case (0x06)
                    {
                        Return (0x03)
                    }
                    Case (0x07)
                    {
                        RQST = DerefOf (Arg3 [Zero])
                        FLAG = 0x07
                        OPTN = Zero
                        If ((RQST == 0x17))
                        {
                            ToInteger (DerefOf (Arg3 [One]), OPTN) /* \_SB_.TPM_.OPTN */
                        }

                        TMF1 = OFST /* \OFST */
                        SRSP = Zero
                        SMI = TMF1 /* \TMF1 */
                        Return (SRSP) /* \_SB_.TPM_.SRSP */
                    }
                    Case (0x08)
                    {
                        RQST = DerefOf (Arg3 [Zero])
                        FLAG = 0x08
                        TMF1 = OFST /* \OFST */
                        SRSP = Zero
                        SMI = TMF1 /* \TMF1 */
                        Return (SRSP) /* \_SB_.TPM_.SRSP */
                    }
                    Default
                    {
                    }

                }
            }
            ElseIf ((Arg0 == ToUUID ("376054ed-cc13-4675-901c-4756d7f2d45d") /* TPM Memory Clear */))
            {
                Switch (ToInteger (Arg2))
                {
                    Case (Zero)
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }
                    Case (One)
                    {
                        RQST = DerefOf (Arg3 [Zero])
                        FLAG = 0x09
                        TMF1 = OFST /* \OFST */
                        SRSP = Zero
                        SMI = TMF1 /* \TMF1 */
                        Return (SRSP) /* \_SB_.TPM_.SRSP */
                    }
                    Default
                    {
                    }

                }
            }

            If ((Arg0 == ToUUID ("cf8e16a5-c1e8-4e25-b712-4f54a96702c8") /* TPM Hardware Information */))
            {
                Return (CRYF (Arg1, Arg2, Arg3))
            }

            If ((Arg0 == ToUUID ("6bbf6cab-5463-4714-b7cd-f0203c0368d4") /* TPM Start Method */))
            {
                Return (STRT (Arg1, Arg2, Arg3))
            }

            Return (Buffer (One)
            {
                 0x00                                             // .
            })
        }

        Method (TPTS, 1, Serialized)
        {
            Switch (ToInteger (Arg0))
            {
                Case (0x04)
                {
                    RQST = Zero
                    FLAG = 0x09
                    SRSP = Zero
                    SMI = OFST /* \OFST */
                }
                Case (0x05)
                {
                    RQST = Zero
                    FLAG = 0x09
                    SRSP = Zero
                    SMI = OFST /* \OFST */
                }

            }

            Sleep (0x012C)
        }
    }

    Scope (_GPE)
    {
    }

    Scope (_SB)
    {
        Name (MWTT, 0x02)
        Scope (FUR0)
        {
            Device (UART)
            {
                Name (_HID, "UTK0001A")  // _HID: Hardware ID
                Name (_CID, "UARTTest")  // _CID: Compatible ID
                Name (_UID, Zero)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x22)
                    {
                        /* 0000 */  0x8E, 0x1D, 0x00, 0x01, 0x00, 0x03, 0x02, 0x35,  // .......5
                        /* 0008 */  0x00, 0x01, 0x0A, 0x00, 0x00, 0xC2, 0x01, 0x00,  // ........
                        /* 0010 */  0x20, 0x00, 0x20, 0x00, 0x00, 0xC0, 0x5C, 0x5F,  //  . ...\_
                        /* 0018 */  0x53, 0x42, 0x2E, 0x46, 0x55, 0x52, 0x30, 0x00,  // SB.FUR0.
                        /* 0020 */  0x79, 0x00                                       // y.
                    })
                    Return (RBUF) /* \_SB_.FUR0.UART._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (FUR1)
        {
            Device (UART)
            {
                Name (_HID, "UTK0001B")  // _HID: Hardware ID
                Name (_CID, "UARTTest")  // _CID: Compatible ID
                Name (_UID, One)  // _UID: Unique ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x22)
                    {
                        /* 0000 */  0x8E, 0x1D, 0x00, 0x01, 0x00, 0x03, 0x02, 0x35,  // .......5
                        /* 0008 */  0x00, 0x01, 0x0A, 0x00, 0x00, 0xC2, 0x01, 0x00,  // ........
                        /* 0010 */  0x20, 0x00, 0x20, 0x00, 0x00, 0xC0, 0x5C, 0x5F,  //  . ...\_
                        /* 0018 */  0x53, 0x42, 0x2E, 0x46, 0x55, 0x52, 0x31, 0x00,  // SB.FUR1.
                        /* 0020 */  0x79, 0x00                                       // y.
                    })
                    Return (RBUF) /* \_SB_.FUR1.UART._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CA)
        {
            Device (WT1A)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001A")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFA")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x41, 0x00, 0x79, 0x00               // 2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.WT1A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1A)
            {
                Name (_HID, "STK0001A")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x41, 0x00, 0x79, 0x00         // I2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.MT1A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2A)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002A")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFA")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x41, 0x00, 0x79, 0x00               // 2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.WT2A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2A)
            {
                Name (_HID, "STK0002A")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x41, 0x00, 0x79, 0x00         // I2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.MT2A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3A)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003A")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFA")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x41, 0x00, 0x79, 0x00               // 2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.WT3A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3A)
            {
                Name (_HID, "STK0003A")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x41, 0x00, 0x79, 0x00         // I2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.MT3A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4A)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004A")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFA")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x41, 0x00, 0x79, 0x00               // 2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.WT4A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4A)
            {
                Name (_HID, "STK0004A")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x41, 0x00, 0x79, 0x00         // I2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.MT4A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5A)
            {
                Name (_HID, "STK0005A")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x41, 0x00, 0x79, 0x00         // I2CA.y.
                    })
                    Return (RBUF) /* \_SB_.I2CA.MT5A._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CB)
        {
            Device (WT1B)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001B")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFB")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x42, 0x00, 0x79, 0x00               // 2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.WT1B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1B)
            {
                Name (_HID, "STK0001B")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x42, 0x00, 0x79, 0x00         // I2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.MT1B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2B)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002B")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFB")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x42, 0x00, 0x79, 0x00               // 2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.WT2B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2B)
            {
                Name (_HID, "STK0002B")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x42, 0x00, 0x79, 0x00         // I2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.MT2B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3B)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003B")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFB")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x42, 0x00, 0x79, 0x00               // 2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.WT3B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3B)
            {
                Name (_HID, "STK0003B")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x42, 0x00, 0x79, 0x00         // I2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.MT3B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4B)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004B")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFB")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x42, 0x00, 0x79, 0x00               // 2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.WT4B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4B)
            {
                Name (_HID, "STK0004B")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x42, 0x00, 0x79, 0x00         // I2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.MT4B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5B)
            {
                Name (_HID, "STK0005B")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x42, 0x00, 0x79, 0x00         // I2CB.y.
                    })
                    Return (RBUF) /* \_SB_.I2CB.MT5B._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CC)
        {
            Device (WT1C)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001C")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFC")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x43, 0x00, 0x79, 0x00               // 2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.WT1C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1C)
            {
                Name (_HID, "STK0001C")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x43, 0x00, 0x79, 0x00         // I2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.MT1C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2C)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002C")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFC")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x43, 0x00, 0x79, 0x00               // 2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.WT2C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2C)
            {
                Name (_HID, "STK0002C")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x43, 0x00, 0x79, 0x00         // I2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.MT2C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3C)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003C")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFC")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x43, 0x00, 0x79, 0x00               // 2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.WT3C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3C)
            {
                Name (_HID, "STK0003C")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x43, 0x00, 0x79, 0x00         // I2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.MT3C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4C)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004C")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFC")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x43, 0x00, 0x79, 0x00               // 2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.WT4C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4C)
            {
                Name (_HID, "STK0004C")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x43, 0x00, 0x79, 0x00         // I2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.MT4C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5C)
            {
                Name (_HID, "STK0005C")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x43, 0x00, 0x79, 0x00         // I2CC.y.
                    })
                    Return (RBUF) /* \_SB_.I2CC.MT5C._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CD)
        {
            Device (WT1D)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001D")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFD")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x44, 0x00, 0x79, 0x00               // 2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.WT1D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1D)
            {
                Name (_HID, "STK0001D")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x44, 0x00, 0x79, 0x00         // I2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.MT1D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2D)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002D")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFD")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x44, 0x00, 0x79, 0x00               // 2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.WT2D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2D)
            {
                Name (_HID, "STK0002D")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x44, 0x00, 0x79, 0x00         // I2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.MT2D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3D)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003D")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFD")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x44, 0x00, 0x79, 0x00               // 2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.WT3D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3D)
            {
                Name (_HID, "STK0003D")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x44, 0x00, 0x79, 0x00         // I2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.MT3D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4D)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004D")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFD")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x44, 0x00, 0x79, 0x00               // 2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.WT4D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4D)
            {
                Name (_HID, "STK0004D")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x44, 0x00, 0x79, 0x00         // I2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.MT4D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5D)
            {
                Name (_HID, "STK0005D")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x44, 0x00, 0x79, 0x00         // I2CD.y.
                    })
                    Return (RBUF) /* \_SB_.I2CD.MT5D._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CE)
        {
            Device (WT1E)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001E")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFE")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x45, 0x00, 0x79, 0x00               // 2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.WT1E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1E)
            {
                Name (_HID, "STK0001E")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x45, 0x00, 0x79, 0x00         // I2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.MT1E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2E)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002E")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFE")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x45, 0x00, 0x79, 0x00               // 2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.WT2E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2E)
            {
                Name (_HID, "STK0002E")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x45, 0x00, 0x79, 0x00         // I2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.MT2E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3E)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003E")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFE")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x45, 0x00, 0x79, 0x00               // 2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.WT3E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3E)
            {
                Name (_HID, "STK0003E")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x45, 0x00, 0x79, 0x00         // I2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.MT3E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4E)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004E")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFE")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x45, 0x00, 0x79, 0x00               // 2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.WT4E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4E)
            {
                Name (_HID, "STK0004E")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x45, 0x00, 0x79, 0x00         // I2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.MT4E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5E)
            {
                Name (_HID, "STK0005E")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x45, 0x00, 0x79, 0x00         // I2CE.y.
                    })
                    Return (RBUF) /* \_SB_.I2CE.MT5E._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Scope (I2CF)
        {
            Device (WT1F)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0001F")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFF")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x7F, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x46, 0x00, 0x79, 0x00               // 2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.WT1F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT1F)
            {
                Name (_HID, "STK0001F")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x46, 0x00, 0x79, 0x00         // I2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.MT1F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT2F)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0002F")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFF")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xA0, 0x86, 0x01, 0x00,  // ........
                        /* 0010 */  0x11, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x46, 0x00, 0x79, 0x00               // 2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.WT2F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT2F)
            {
                Name (_HID, "STK0002F")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x46, 0x00, 0x79, 0x00         // I2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.MT2F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT3F)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0003F")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFF")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x80, 0x1A, 0x06, 0x00,  // ........
                        /* 0010 */  0x12, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x46, 0x00, 0x79, 0x00               // 2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.WT3F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT3F)
            {
                Name (_HID, "STK0003F")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x46, 0x00, 0x79, 0x00         // I2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.MT3F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (WT4F)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "STK0004F")  // _HID: Hardware ID
                Name (_CID, "SPBTestKMDFF")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1E)
                    {
                        /* 0000 */  0x8E, 0x19, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x40, 0x42, 0x0F, 0x00,  // ....@B..
                        /* 0010 */  0x13, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x2E, 0x49,  // ..\_SB.I
                        /* 0018 */  0x32, 0x43, 0x46, 0x00, 0x79, 0x00               // 2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.WT4F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT4F)
            {
                Name (_HID, "STK0004F")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0xE0, 0x22, 0x02, 0x00,  // ....."..
                        /* 0010 */  0x14, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x46, 0x00, 0x79, 0x00         // I2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.MT4F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }

            Device (MT5F)
            {
                Name (_HID, "STK0005F")  // _HID: Hardware ID
                Name (_CID, "WITTTest")  // _CID: Compatible ID
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, Buffer (0x1F)
                    {
                        /* 0000 */  0x8E, 0x1A, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00,  // ........
                        /* 0008 */  0x00, 0x01, 0x06, 0x00, 0x20, 0x30, 0x05, 0x00,  // .... 0..
                        /* 0010 */  0x15, 0x00, 0x5C, 0x5F, 0x53, 0x42, 0x5F, 0x2E,  // ..\_SB_.
                        /* 0018 */  0x49, 0x32, 0x43, 0x46, 0x00, 0x79, 0x00         // I2CF.y.
                    })
                    Return (RBUF) /* \_SB_.I2CF.MT5F._CRS.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((MWTT == Zero))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Method (SDRT, 0, NotSerialized)
        {
        }
    }

    Name (GNLD, 0x02)
    Name (OBDP, 0x00)
    Method (DBGL, 1, NotSerialized)
    {
        If ((Arg0 == One))
        {
            \_SB.PCI0.SBRG.SIO1.ENFG (0x0F)
            \_SB.PCI0.SBRG.SIO1.OPT1 &= Zero
            \_SB.PCI0.SBRG.SIO1.EXFG ()
        }
        Else
        {
            \_SB.PCI0.SBRG.SIO1.ENFG (0x0F)
            \_SB.PCI0.SBRG.SIO1.OPT1 |= 0x02
            \_SB.PCI0.SBRG.SIO1.EXFG ()
        }
    }

    Method (SYSL, 1, NotSerialized)
    {
        If ((Arg0 == One)){}
        Else
        {
        }
    }

    Method (LEDS, 1, NotSerialized)
    {
        If ((OBDP == Zero))
        {
            DBGL (One)
            P80H = Arg0
        }

        If ((GNLD == One)){}
    }

    Method (LEDW, 1, NotSerialized)
    {
        If ((OBDP == Zero))
        {
            DBGL (Zero)
            P80H = (Arg0 << 0x04)
        }

        If ((GNLD == 0x02))
        {
            SYSL (Zero)
        }

        If ((GNLD == One)){}
    }

    Scope (_SB.PCI0)
    {
        Name (SLIC, Buffer (0x9E)
        {
            "648655725788Genuine NVIDIA Certified SLI Ready Motherboard for ASROCK X399 TAICHI  10fd-Copyright 2017 NVIDIA Corporation All Rights Reserved-933399180831(R)"
        })
        Device (WMI1)
        {
            Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, "MXM2")  // _UID: Unique ID
            Name (_WDG, Buffer (0x14)
            {
                /* 0000 */  0x3C, 0x5C, 0xCB, 0xF6, 0xAE, 0x9C, 0xBD, 0x4E,  // <\.....N
                /* 0008 */  0xB5, 0x77, 0x93, 0x1E, 0xA3, 0x2A, 0x2C, 0xC0,  // .w...*,.
                /* 0010 */  0x4D, 0x58, 0x01, 0x02                           // MX..
            })
            Method (WMMX, 3, NotSerialized)
            {
                CreateDWordField (Arg2, Zero, FUNC)
                If ((FUNC == 0x41494C53))
                {
                    Return (SLIC) /* \_SB_.PCI0.SLIC */
                }

                Return (Zero)
            }
        }
    }
}

