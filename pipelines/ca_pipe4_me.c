/**
 * Codasip s.r.o.
 *
 * CONFIDENTIAL
 *
 * Copyright 2022 Codasip s.r.o.
 *
 * All Rights Reserved.
 *
 * NOTICE: All information contained in this file, is and shall remain the property of
 * Codasip s.r.o. and its suppliers, if any.
 *
 * The intellectual and technical concepts contained herein are confidential and proprietary to
 * Codasip s.r.o. and are protected by trade secret and copyright law.  In addition, elements of the
 * technical concepts may be patent pending.
 *
 * This file is part of the Codasip Studio product. No part of the Studio product, including this
 * file, may be use, copied, modified, or distributed except in accordance with the terms contained
 * in Codasip license agreement under which you obtained this file.
 *
 *  \file   ca_pipe4_me.codal
 *  \author Codasip
 *  \date   09.02.2022
 *  \brief  cycle accurate model
 */

#include "ca_defines.hcodal"
#include "config.hcodal"

// -------------------------------------------------------------------------------------------------
// Memory Stage
// -------------------------------------------------------------------------------------------------
event me : pipeline(pipe.MEMWB)
{
    use me_output;

    semantics
    {

        // Update the pipeline registers between the Memory (MEM) and Write Back (WB) stages
        me_output();
    };
};

event me_output : pipeline(pipe.MEMWB)
{
    semantics
    {
        // ALU result from the EXMEM pipeline register to pass along to the WB stage
        r_memwb_alu_result = r_exmem_alu_result;
        // Passing control signals to the next stage, WB, through the MEMWB pipeline register
        r_memwb_rd = r_exmem_rd;
        r_memwb_regwrite = r_exmem_regwrite;
    };
};
