<%
    /**
     * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
     *
     * This library is free software; you can redistribute it and/or modify it
     * under the terms of the GNU Lesser General Public License as published by
     * the Free Software Foundation; either version 2.1 of the License, or (at
     * your option) any later version.
     *
     * This library is distributed in the hope that it will be useful, but
     * WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
     * General Public License for more details.
     */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<%//
    // GATE 6.0.0 Submission Form
    //
    // The form has 3 input textareas respectively for:
    //    * Macro file
    //    * Material DB
    //    * ROOT Analysis C file
    // Beside each text area a upolad button takes as input the 
    // file name related to one of the above fields.
    // The forth submission buttons is related to the file 'phsp.root' file
    // A default phsp.root file will be used if no files will be uploaded by the user.
    // The ohter three buttons of the form are used for:
    //    o Demo:          Used to fill with demo values the text areas
    //    o SUBMIT:        Used to execute the job on the eInfrastructure
    //    o Reset values:  Used to reset input fields
    //
    // Gets the current timestamp
    java.util.Date date = new java.util.Date();
%>

<%
// Below the descriptive area of the GATE web form 
%>
<table>
    <tr>
        <td valign="top">
            <img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.jpg" width="80%"/>
        </td>
        <td>
            <!--This is an example portlet!
             <p><b>Exchange data between jsp page and java codeeee</b></p>-->

            <p style="font-size: small"> 
                GADGET is a freely available code for cosmological N-body/SPH simulations <br> 
                on massively parallel computers with distributed memory.<br> 
                GADGET uses an explicit communication model that is implemented<br>
                with the standardized MPI communication interface. <br>
                The code can be run on essentially all supercomputer systems presently in use,<br>
                including clusters of workstations or individual PCs.  
            </p>
        </td>
    <tr>
</table>

<form enctype="multipart/form-data" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_FILE"/></portlet:actionURL>" method="post">
<div style="text-align: center;">
    <dl>	
        <!-- This block contains: label, file input and textarea for GATE Macro file -->
        <dd>		
            <p><b>Application input file</b> <input type="file" name="file_inputFile" id="upload_inputFileId" accept="*.*" onchange="uploadInputFile()"/></p>
            <div hidden="yes">
                <textarea id="inputFileId" rows="20" cols="100%" name="inputFile">Insert here your text file, or upload a file</textarea>
            </div>
        </dd>
        <div hidden="yes">
            <!-- This block contains the experiment name -->
            <dd>
                <p>Insert below your <b>job identifyer</b></p>
                <textarea id="jobIdentifierId" rows="1" cols="60%" name="JobIdentifier">multi-infrastructure job description</textarea>
            </dd>	
            <!-- This block contains form buttons: Demo, SUBMIT and Reset values -->
            <dd>
            <td><input type="button" value="Demo" onClick="addDemo()"></td>
            <td><input type="button" value="Submit" onClick="preSubmit()"></td> 
            <td><input type="reset" value="Reset values" onClick="resetForm()"></td>
            </dd>
        </div>
    </dl>
    <br/><br/>
</div>    
</form>            



<%
// Below the application submission web form 
//
// The <form> tag contains a portlet parameter value called 'PortletStatus' the value of this item
// will be read by the processAction portlet method which then assigns a proper view mode before
// the call to the doView method.
// PortletStatus values can range accordingly to values defined into Enum type: Actions
// The processAction method will assign a view mode accordingly to the values defined into
// the Enum type: Views. This value will be assigned calling the function: setRenderParameter
//
%>

<!-- <div>
     <form  action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">

             <b>Input value</b> 
             <input type="text" id="inputValueId" name="inputValue" />

             <input type="submit" value="GO">

     </form>
 </div>
 <br>
 <div>
     <form  action="<portlet:renderURL portletMode="view"><portlet:param name="PortletStatus" value="VIEW_NO_ACTION"/></portlet:renderURL>" method="post">

             <b>Go a new JSP page without Action</b> 
             <input type="submit" value="GO">

     </form>
 </div>
 
-->

<script src="<%=renderRequest.getContextPath()%>/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<form id="form_music" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_GADGET"/></portlet:actionURL>" method="post">



<div id="container">
    <table>
        <tr>

            <td>
                <!-- <div id="gadget2_setup1">Click to add the setup value</div>-->
                <div id="gadget">
                    <center>
                        <fieldset class="gadget2_fieldset" >

                            <legend class="gadget2_legend"> GADGET VALUES </legend>
                            <table>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPERIODIC"  >PERIODIC *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="checkbox" name="PERIODIC" id="PERIODIC_ID" value=false>
                                       
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelUNEQUALSOFTENINGS"  >UNEQUALSOFTENINGS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPEANOHILBERT"  >PEANOHILBERT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PEANOHILBERT" id="PEANOHILBERT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PEANOHILBERT" id="PEANOHILBERT_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelWALLCLOCK">WALLCLOCK </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="WALLCLOCK" id="WALLCLOCK_Y_ID" value="Y"> Y 
                                        <input type="radio" name="WALLCLOCK" id="WALLCLOCK_N_ID" value="N"> N
                                    </td>
                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPMGRID"  >PMGRID * </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PMGRID" id="PMGRID_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PMGRID" id="PMGRID_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPLACEHIGHRESREGION"  >PLACEHIGHRESREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="PLACEHIGHRESREGIONID" name="PLACEHIGHRESREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelENLARGEREGION"  >ENLARGEREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ENLARGEREGIONID" name="ENLARGEREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelASMTH"  >ASMTH </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ASMTHID" name="ASMTH" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelRCUT"  >RCUT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="RCUTID" name="RCUT" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION"  >DOUBLEPRECISION *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION_FFTW"  >DOUBLEPRECISION_FFTW *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="DOUBLEPRECISION_FFTW" id="DOUBLEPRECISION_FFTW_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION_FFTW" id="DOUBLEPRECISION_FFTW_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSYNCHRONIZATION"  >SYNCHRONIZATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="checkbox" name="SYNCHRONIZATION" id="SYNCHRONIZATIONID" value="">  


                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelFLEXSTEPS"  >FLEXSTEPS *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="FLEXSTEPS" id="FLEXSTEPS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="FLEXSTEPS" id="FLEXSTEPS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPSEUDOSYMMETRIC"  >PSEUDOSYMMETRIC </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOSTOP_WHEN_BELOW_MINTIMESTEP"  >NOSTOP_WHEN_BELOW_MINTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOPMSTEPADJUSTMENT"  >NOPMSTEPADJUSTMENT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelHAVE_HDF5"  >HAVE_HDF5 * </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="HAVE_HDF5" id="HAVE_HDF5_Y_ID" value="Y"> Y 
                                        <input type="radio" name="HAVE_HDF5" id="HAVE_HDF5_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTPOTENTIAL"  >OUTPUTPOTENTIAL </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTACCELERATION"  >OUTPUTACCELERATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTCHANGEOFENTROPY"  >OUTPUTCHANGEOFENTROPY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTTIMESTEP"  >OUTPUTTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOGRAVITY"  >NOGRAVITY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOGRAVITY" id="NOGRAVITY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOGRAVITY" id="NOGRAVITY_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOTREERND"  >NOTREERND </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOTREERND" id="NOTREERND_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOTREERND" id="NOTREERND_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOTYPEPREFIX_FFTW"  >NOTYPEPREFIX_FFTW </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOTYPEPREFIX_FFTW" id="NOTYPEPREFIX_FFTW_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOTYPEPREFIX_FFTW" id="NOTYPEPREFIX_FFTW_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelLONG_XYZ"  > LONG_X/Y/Z </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="LONG_XYZ" id="LONG_XYZ_Y_ID" value="Y"> Y 
                                        <input type="radio" name="LONG_XYZ" id="LONG_XYZ_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTWODIMS"  > TWODIMS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="TWODIMS" id="TWODIMS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="TWODIMS" id="TWODIMS_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSPH_BND_PARTICLES"  > SPH_BND_PARTICLES </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="SPH_BND_PARTICLES" id="SPH_BND_PARTICLES_Y_ID" value="Y"> Y 
                                        <input type="radio" name="SPH_BND_PARTICLES" id="SPH_BND_PARTICLES_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOVISCOSITYLIMITER"  > NOVISCOSITYLIMITER </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOVISCOSITYLIMITER" id="NOVISCOSITYLIMITER_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOVISCOSITYLIMITER" id="NOVISCOSITYLIMITER_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelCOMPUTE_POTENTIAL_ENERGY"  > COMPUTE_POTENTIAL_ENERGY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="COMPUTE_POTENTIAL_ENERGY" id="COMPUTE_POTENTIAL_ENERGY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="COMPUTE_POTENTIAL_ENERGY" id="COMPUTE_POTENTIAL_ENERGY_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelLONGIDS"  > LONGIDS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="LONGIDS" id="LONGIDS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="LONGIDS" id="LONGIDS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelISOTHERMAL"  > ISOTHERMAL </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="ISOTHERMAL" id="ISOTHERMAL_Y_ID" value="Y"> Y 
                                        <input type="radio" name="ISOTHERMAL" id="ISOTHERMAL_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSELECTIVE_NO_GRAVITY"  > SELECTIVE_NO_GRAVITY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="SELECTIVE_NO_GRAVITY" id="SELECTIVE_NO_GRAVITY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="SELECTIVE_NO_GRAVITY" id="SELECTIVE_NO_GRAVITY_N_ID" value="N"> N
                                    </td>

                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelFORCETEST"  > FORCETEST </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="FORCETESTID" name="FORCETEST" type="text" value=""/>


                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelMAKEGLASS"  > MAKEGLASS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="MAKEGLASS" id="MAKEGLASS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="MAKEGLASS" id="MAKEGLASS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="3" align="center"><input type="button" value="Demo" onclick="SetGADGETDemoValues()">
                                        <input type="button" value="Reset" onclick="ResetGADGETValues()">
                                        <input type="button" value="Validate Random" onclick="ValidateGADGETValues()">
                                    </td>

                                </tr>


                            </table>
                        </fieldset>
                    </center>
                </div>




                <div align="center"><input type="button" value="Submit" onClick="SubmitGadgetParam()"></div>
                </form>

                <script>
                 
                    var gadgetIsValidate=false;
    
                    function SetGADGETDemoValues(){
       
      
        
        
                        if(document.getElementById("PERIODIC_ID").value==false){
                            document.getElementById("PERIODIC_ID").checked=true;
                            document.getElementById("labelPERIODIC").style.color="black";
                        }
       
       
       
                        if(document.getElementById("UNEQUALSOFTENINGS_N_ID").value=="N"){
                            document.getElementById("UNEQUALSOFTENINGS_N_ID").checked=true;
                            document.getElementById("labelUNEQUALSOFTENINGS").style.color="black";
                        }
    
       
                        if(document.getElementById("PEANOHILBERT_Y_ID").value=="Y"){
                            document.getElementById("PEANOHILBERT_Y_ID").checked=true;
                            document.getElementById("labelPEANOHILBERT").style.color="black";
                        }
                        if(document.getElementById("WALLCLOCK_N_ID").value=="N"){
                            document.getElementById("WALLCLOCK_N_ID").checked=true;
                            document.getElementById("labelWALLCLOCK").style.color="black";
                        }
       
       
                        if(document.getElementById("PMGRID_Y_ID").value=="Y"){
                            document.getElementById("PMGRID_Y_ID").checked=true;
                            document.getElementById("labelPMGRID").style.color="black";
                        }
       
       
                        document.getElementById("PLACEHIGHRESREGIONID").value="19";
                        document.getElementById("labelPLACEHIGHRESREGION").style.color="black";
        
                        document.getElementById("ENLARGEREGIONID").value="1.1";
                        document.getElementById("labelENLARGEREGION").style.color="black";
        
        
                        document.getElementById("ASMTHID").value="1.25";
                        document.getElementById("labelASMTH").style.color="black";
        
                        document.getElementById("RCUTID").value="4.5";
                        document.getElementById("labelRCUT").style.color="black";
        
                        if(document.getElementById("DOUBLEPRECISION_Y_ID").value=="Y"){
                            document.getElementById("DOUBLEPRECISION_Y_ID").checked=true;
                            document.getElementById("labelDOUBLEPRECISION").style.color="black";
                        }
                        if(document.getElementById("DOUBLEPRECISION_FFTW_Y_ID").value=="Y"){
                            document.getElementById("DOUBLEPRECISION_FFTW_Y_ID").checked=true;
                            document.getElementById("labelDOUBLEPRECISION_FFTW").style.color="black";
                        }
        
                        if(document.getElementById("SYNCHRONIZATIONID").checked==true){
                            document.getElementById("SYNCHRONIZATIONID").value=true;
                            document.getElementById("labelSYNCHRONIZATION").style.color="black";
                        }
        
        
                        if(document.getElementById("FLEXSTEPS_Y_ID").value=="Y"){
                            document.getElementById("FLEXSTEPS_Y_ID").checked=true;
                            document.getElementById("labelFLEXSTEPS").style.color="black";
                        }
      
                        if(document.getElementById("PSEUDOSYMMETRIC_N_ID").value=="N"){
                            document.getElementById("PSEUDOSYMMETRIC_N_ID").checked=true;
                            document.getElementById("labelPSEUDOSYMMETRIC").style.color="black";
                        }
                        if(document.getElementById("NOSTOP_WHEN_BELOW_MINTIMESTEP_N_ID").value=="N"){
                            document.getElementById("NOSTOP_WHEN_BELOW_MINTIMESTEP_N_ID").checked=true;
                            document.getElementById("labelNOSTOP_WHEN_BELOW_MINTIMESTEP").style.color="black";
                        }
        
                        if(document.getElementById("NOPMSTEPADJUSTMENT_N_ID").value=="N"){
                            document.getElementById("NOPMSTEPADJUSTMENT_N_ID").checked=true;
                            document.getElementById("labelNOPMSTEPADJUSTMENT").style.color="black";
                        }
                        if(document.getElementById("HAVE_HDF5_N_ID").value=="N"){
                            document.getElementById("HAVE_HDF5_N_ID").checked=true;
                            document.getElementById("labelHAVE_HDF5").style.color="black";
                        }
                        if(document.getElementById("OUTPUTPOTENTIAL_N_ID").value=="N"){
                            document.getElementById("OUTPUTPOTENTIAL_N_ID").checked=true;
                            document.getElementById("labelOUTPUTPOTENTIAL").style.color="black";
                        }
                        
                        
                        if(document.getElementById("OUTPUTACCELERATION_N_ID").value=="N"){
                            document.getElementById("OUTPUTACCELERATION_N_ID").checked=true;
                            document.getElementById("labelOUTPUTACCELERATION").style.color="black";
                        }
                        if(document.getElementById("OUTPUTCHANGEOFENTROPY_N_ID").value=="N"){
                            document.getElementById("OUTPUTCHANGEOFENTROPY_N_ID").checked=true;
                            document.getElementById("labelOUTPUTCHANGEOFENTROPY").style.color="black";
                        }
                        
                        if(document.getElementById("OUTPUTTIMESTEP_N_ID").value=="N"){
                            document.getElementById("OUTPUTTIMESTEP_N_ID").checked=true;
                            document.getElementById("labelOUTPUTTIMESTEP").style.color="black";
                        }
                      
                        if(document.getElementById("NOGRAVITY_N_ID").value=="N"){
                            document.getElementById("NOGRAVITY_N_ID").checked=true;
                            document.getElementById("labelNOGRAVITY").style.color="black";
                        }
                        
                  
                         
                        if(document.getElementById("NOTREERND_N_ID").value=="N"){
                            document.getElementById("NOTREERND_N_ID").checked=true;
                            document.getElementById("labelNOTREERND").style.color="black";
                        }
                        if(document.getElementById("NOTYPEPREFIX_FFTW_N_ID").value=="N"){
                            document.getElementById("NOTYPEPREFIX_FFTW_N_ID").checked=true;
                            document.getElementById("labelNOTYPEPREFIX_FFTW").style.color="black";
                        }
                        if(document.getElementById("LONG_XYZ_N_ID").value=="N"){
                            document.getElementById("LONG_XYZ_N_ID").checked=true;
                            document.getElementById("labelLONG_XYZ").style.color="black";
                        }
                        if(document.getElementById("TWODIMS_N_ID").value=="N"){
                            document.getElementById("TWODIMS_N_ID").checked=true;
                            document.getElementById("labelTWODIMS").style.color="black";
                        }
                        if(document.getElementById("SPH_BND_PARTICLES_N_ID").value=="N"){
                            document.getElementById("SPH_BND_PARTICLES_N_ID").checked=true;
                            document.getElementById("labelSPH_BND_PARTICLES").style.color="black";
                        }
                        
                        
                
                        
                        if(document.getElementById("NOVISCOSITYLIMITER_N_ID").value=="N"){
                            document.getElementById("NOVISCOSITYLIMITER_N_ID").checked=true;
                            document.getElementById("labelNOVISCOSITYLIMITER").style.color="black";
                        }
                        if(document.getElementById("COMPUTE_POTENTIAL_ENERGY_Y_ID").value=="Y"){
                            document.getElementById("COMPUTE_POTENTIAL_ENERGY_Y_ID").checked=true;
                            document.getElementById("labelCOMPUTE_POTENTIAL_ENERGY").style.color="black";
                        }
                        
                        if(document.getElementById("LONGIDS_Y_ID").value=="Y"){
                            document.getElementById("LONGIDS_Y_ID").checked=true;
                            document.getElementById("labelLONGIDS").style.color="black";
                        }
                        
                        if(document.getElementById("ISOTHERMAL_N_ID").value=="N"){
                            document.getElementById("ISOTHERMAL_N_ID").checked=true;
                            document.getElementById("labelISOTHERMAL").style.color="black";
                        }
                        if(document.getElementById("SELECTIVE_NO_GRAVITY_N_ID").value=="N"){
                            document.getElementById("SELECTIVE_NO_GRAVITY_N_ID").checked=true;
                            document.getElementById("labelSELECTIVE_NO_GRAVITY").style.color="black";
                        }
                  
        
        
                        document.getElementById("FORCETESTID").value="0";
                        document.getElementById("labelFORCETEST").style.color="black";
                        
                        if(document.getElementById("MAKEGLASS_N_ID").value=="N"){
                            document.getElementById("MAKEGLASS_N_ID").checked=true;
                            document.getElementById("labelMAKEGLASS").style.color="black";
                        }

      
                    }
                    
                    
                    function ResetGADGETValues(){
        
              
                         
                       
                        document.getElementById("PERIODIC_Y_ID").checked=false;
                        document.getElementById("PERIODIC_N_ID").checked=false;
                            
                            
                        document.getElementById("UNEQUALSOFTENINGS_Y_ID").checked=false;
                        document.getElementById("UNEQUALSOFTENINGS_N_ID").checked=false;
                            
                        document.getElementById("PEANOHILBERT_Y_ID").checked=false;
                        document.getElementById("PEANOHILBERT_N_ID").checked=false;
                       
                        document.getElementById("WALLCLOCK_Y_ID").checked=false;
                        document.getElementById("WALLCLOCK_N_ID").checked=false;
                    
                            
                            
                      
                        document.getElementById("PMGRID_Y_ID").checked=false;
                        document.getElementById("PMGRID_N_ID").checked=false;
        
                        document.getElementById("PLACEHIGHRESREGIONID").value="";
                            
                        document.getElementById("ENLARGEREGIONID").value="";
                            
                        document.getElementById("ASMTHID").value="";
                             
                        document.getElementById("RCUTID").value="";
                            
                           
                      
                        document.getElementById("DOUBLEPRECISION_N_ID").checked=false;
                        document.getElementById("DOUBLEPRECISION_Y_ID").checked=false;
        
                      
                        document.getElementById("DOUBLEPRECISION_FFTW_Y_ID").checked=false;
                        document.getElementById("DOUBLEPRECISION_FFTW_N_ID").checked=false;
        
                      
                      
                        document.getElementById("SYNCHRONIZATIONID").checked=false;
                            
                      
                              
                        document.getElementById("FLEXSTEPS_Y_ID").checked=false;
                        document.getElementById("FLEXSTEPS_N_ID").checked=false;
                         
                        document.getElementById("PSEUDOSYMMETRIC_Y_ID").checked=false;
                        document.getElementById("PSEUDOSYMMETRIC_N_ID").checked=false;
                        
                        document.getElementById("NOSTOP_WHEN_BELOW_MINTIMESTEP_Y_ID").checked=false;
                        document.getElementById("NOSTOP_WHEN_BELOW_MINTIMESTEP_N_ID").checked=false;
                        
                        document.getElementById("NOPMSTEPADJUSTMENT_Y_ID").checked=false;
                        document.getElementById("NOPMSTEPADJUSTMENT_N_ID").checked=false;
                        
                        document.getElementById("HAVE_HDF5_Y_ID").checked=false;
                        document.getElementById("HAVE_HDF5_N_ID").checked=false;
                      
                        
                        document.getElementById("OUTPUTPOTENTIAL_Y_ID").checked=false;
                        document.getElementById("OUTPUTPOTENTIAL_N_ID").checked=false;
                        
                        document.getElementById("OUTPUTACCELERATION_Y_ID").checked=false;
                        document.getElementById("OUTPUTACCELERATION_N_ID").checked=false;
                        
                        document.getElementById("OUTPUTCHANGEOFENTROPY_Y_ID").checked=false;
                        document.getElementById("OUTPUTCHANGEOFENTROPY_N_ID").checked=false;
                        
                        document.getElementById("OUTPUTTIMESTEP_Y_ID").checked=false;
                        document.getElementById("OUTPUTTIMESTEP_N_ID").checked=false;
                        
                        document.getElementById("NOGRAVITY_Y_ID").checked=false;
                        document.getElementById("NOGRAVITY_N_ID").checked=false;
                      
                      
                              
                        document.getElementById("NOTREERND_Y_ID").checked=false;
                        document.getElementById("NOTREERND_N_ID").checked=false;
                        
                        document.getElementById("NOTYPEPREFIX_FFTW_Y_ID").checked=false;
                        document.getElementById("NOTYPEPREFIX_FFTW_N_ID").checked=false;
                        
                        document.getElementById("LONG_XYZ_Y_ID").checked=false;
                        document.getElementById("LONG_XYZ_N_ID").checked=false;
                        
                        document.getElementById("TWODIMS_Y_ID").checked=false;
                        document.getElementById("TWODIMS_N_ID").checked=false;
                        
                        document.getElementById("SPH_BND_PARTICLES_Y_ID").checked=false;
                        document.getElementById("SPH_BND_PARTICLES_N_ID").checked=false;
                        
                        
                        
                        document.getElementById("NOVISCOSITYLIMITER_N_ID").checked=false;
                        document.getElementById("NOVISCOSITYLIMITER_N_ID").checked=false;
                        
                        document.getElementById("COMPUTE_POTENTIAL_ENERGY_Y_ID").checked=false;
                        document.getElementById("COMPUTE_POTENTIAL_ENERGY_Y_ID").checked=false;
                        
                        document.getElementById("LONGIDS_Y_ID").checked=false;
                        document.getElementById("LONGIDS_Y_ID").checked=false;
                        
                        document.getElementById("ISOTHERMAL_N_ID").checked=false;
                        document.getElementById("ISOTHERMAL_N_ID").checked=false;
                        
                        document.getElementById("SELECTIVE_NO_GRAVITY_N_ID").checked=false;
                        document.getElementById("SELECTIVE_NO_GRAVITY_N_ID").checked=false;
                        
                        document.getElementById("FORCETESTID").value="";
                       
                        document.getElementById("MAKEGLASS_Y_ID").checked=false;
                        document.getElementById("MAKEGLASS_N_ID").checked=false;
                        
                           
                      
                       
        
                      
                      
        
                    }                
                    function ValidateGADGETValues(){
                          
                         
                         
                         
                        var  bool= true; //bool

        
                        if( document.getElementById("HAVE_HDF5_Y_ID").checked== false &&  document.getElementById("HAVE_HDF5_N_ID").checked== false){
                            document.getElementById("labelHAVE_HDF5").style.color="red";
                            bool=false;
                            document.getElementById("HAVE_HDF5_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelHAVE_HDF5").style.color="black";
            
                        }
        
                        if( document.getElementById("FLEXSTEPS_Y_ID").checked== false &&  document.getElementById("FLEXSTEPS_N_ID").checked== false){
                            document.getElementById("labelFLEXSTEPS").style.color="red";
                            bool=false;
                            document.getElementById("FLEXSTEPS_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelFLEXSTEPS").style.color="black";
            
                        }
                        
                        
                        if( document.getElementById("DOUBLEPRECISION_N_ID").checked== false &&  document.getElementById("DOUBLEPRECISION_Y_ID").checked== false){
                            document.getElementById("labelDOUBLEPRECISION").style.color="red";
                            bool=false;
                            document.getElementById("DOUBLEPRECISION_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelDOUBLEPRECISION").style.color="black";
            
                        }
                        
                        if( document.getElementById("DOUBLEPRECISION_FFTW_N_ID").checked== false &&  document.getElementById("DOUBLEPRECISION_FFTW_Y_ID").checked== false){
                            document.getElementById("labelDOUBLEPRECISION_FFTW").style.color="red";
                            bool=false;
                            document.getElementById("DOUBLEPRECISION_FFTW_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelDOUBLEPRECISION_FFTW").style.color="black";
            
                        }
                        if( document.getElementById("PMGRID_N_ID").checked== false &&  document.getElementById("PMGRID_Y_ID").checked== false){
                            document.getElementById("labelPMGRID").style.color="red";
                            bool=false;
                            document.getElementById("PMGRID_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelPMGRID").style.color="black";
            
                        }
                        if( document.getElementById("PERIODIC_N_ID").checked== false &&  document.getElementById("PERIODIC_Y_ID").checked== false){
                            document.getElementById("labelPERIODIC").style.color="red";
                            bool=false;
                            document.getElementById("PERIODIC_Y_ID").focus();
                        }
                        else{
                            document.getElementById("labelPERIODIC").style.color="black";
            
                        }
        
            
                        if(bool==false){
                             alert("Oops ! \n Something went wrong with the input parameters. \n Please check the parameters highlighted in red");
                        }
                        else{
            
                            gadgetIsValidate=true;
                            alert("Validate GADGET "+gadgetIsValidate);
                        }
                    }
    
    
                          
                       
                         
         
        
                      
                         
                     
                </script>



