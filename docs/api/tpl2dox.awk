BEGIN {
  groupOpen=0
  bracesOpen=0
  functionOpen=0
  lcInstance=0
  sectionName=""
  functionName=""
  sep = " ";
  commentBuffer = ""
  # this is all one string
    tplType = " _3darray _4darray _5darray _6darray _7darray SPinit_3darray SPinit_4darray SPinit_bounded_3darray SPinit_bounded_matrix SPinit_bounded_number SPinit_bounded_vector SPinit_imatrix SPinit_int SPinit_ivector SPinit_matrix SPinit_number SPinit_vector SPint SPivector SPmatrix SPnumber SPvector constant_quadratic_penalty dll_3darray dll_adstring dll_imatrix dll_init_3darray dll_init_bounded_number dll_init_bounded_vector dll_init_imatrix dll_init_int dll_init_matrix dll_init_number dll_init_vector dll_int dll_matrix dll_number dll_random_effects_vector dll_vector equality_constraint_vector gaussian_prior inequality_constraint_vector init_3darray init_4darray init_5darray init_6darray init_7darray init_adstring init_bounded_3darray init_bounded_dev_vector init_bounded_matrix init_bounded_matrix_vector init_bounded_number init_bounded_number_vector init_bounded_vector init_bounded_vector_vector init_imatrix init_int init_ivector init_line_adstring init_matrix init_matrix_vector init_number init_number_vector init_vector init_vector_vector likeprof_number matrix normal_prior number objective_function_value quadratic_penalty quadratic_prior random_effects_bounded_matrix random_effects_bounded_vector random_effects_matrix random_effects_vector sdreport_matrix sdreport_number sdreport_vector splus_3darray splus_adstring splus_imatrix splus_init_3darray splus_init_bounded_number splus_init_bounded_vector splus_init_matrix splus_init_number splus_init_vector splus_int splus_matrix splus_number splus_vector vector"
  
  print "/** \\defgroup DATA_SECTION DATA_SECTION"
  print "    \\details Input data and other constant objects.\n*/\n"

  print "/** \\defgroup PARAMETER_SECTION PARAMETER_SECTION"
  print "    \\details Model parameters to be estimated and other variable objects.\n*/\n"

  print "/** \\defgroup PROCEDURE_SECTION tpl FUNCTIONS"
  print "    \\details FUNCTIONS declared in the tpl PROCEDURE_SECTION.\n*/\n"
   
   print "/** \\defgroup zLIB Classes defined automatically."
   print "    \\details Forward declarations inserted by tpl2dox script to prevent documenting variable declarations as functions."
   print "*/"
   print "\n"

   print "/** \\defgroup AUTO Classes defined in AUDODIF library."
   print " \\ingroup zLIB */"
   print "\n"
   print "/** \\defgroup ADMB Classes defined in ADMB library."
   print " \\ingroup zLIB */"
   print "\n"

  ADType = "  adstring imatrix ivector ofstream random_number_generator int"

  tplDoxString = "ADMB Template Type. See ADModel Builder Manual."
  split(tplType,tplTypeArray," ")
  for (i in tplTypeArray)
  {
    print "/** "tplDoxString "\\ingroup ADMB */"
    print "class "tplTypeArray[i] " {public: "tplTypeArray[i]"();};"
  }

  ADDoxString = "AUTODIF Type. See AUTODIF api documentation for details."
  split(ADType, ADTypeArray," ")
  for (i in ADTypeArray)
  {
    print "/**  "ADDoxString "\\ingroup AUTO */"
    print "class "ADTypeArray[i] " {public: "ADTypeArray[i]"();};"
  }
  print "\n"

} # end of BEGIN

# processing starts here
{
  # save doxygen comment block in a buffer for later use
  if ($1 == "/**")
  {
     commentBuffer = "  "$1"\n  \\ingroup  PROCEDURE_SECTION\n "
     for (i = 2; i<=NF;i++)
        commentBuffer = commentBuffer" "$i

     while ($NF != "*/")
     {
        getline
        commentBuffer = commentBuffer"\n"$0
     }
   # print "// $NF: "$NF
     getline
  }
# if (commentBuffer != "")
#   print "// commentBuffer: "commentBuffer

  sub("!!","//  !!")
  sub("!!","  ")
  sub("LOCAL_CALC*","  ")
  sub("END_CALC*","  ")
  sub("  cout","  //cout")
# sub("3darray","d3_array")
# sub("4darray","d4_array")
# sub(".*TRACE.*)", "&;")
  sub(" 3darray"," _3darray")
  sub(" 4darray"," _4darray")

  if (match($1, "^.*_SECTION") > 0)
  {
  # if (token == "FUNCTION")
  #     closeBraces()
    if (functionOpen)
      closeFunction()
  # token = $1

    closeSection()

    if ($1 == "DATA_SECTION")
    {
       openSection($1)
       print "class model_data : public ad_comm\n{"

    }
    else if ($1 == "PARAMETER_SECTION")
    {
       openSection($1)
       print "class model_parameters : public model_data,"
       print "      public function_minimizer\n{"
    }
    else
    {
       openSection("")
    }

  }

  else if ($1 == "FUNCTION")
  {
    closeSection()
  # print "// functionOpen: "functionOpen
  # print "// NF: "NF,$0
  # print "// "$1,"++",$2
    if (functionOpen)
      closeFunction()
    if (commentBuffer != "")
    {
  #    print "// printing commentBuffer"
       print "\n"commentBuffer
       commentBuffer=""
  #    print "// finished printing commentBuffer"
    }
  # print "// NF: "NF,$0,token
  # if (token == "FUNCTION")
  # token = $1
    fline = ""
    #print "//@{  //" groupOpen
    #print "/// \\ingroup  PROCEDURE_SECTION"
    #groupOpen = groupOpen + 1
    sectionName = "FUNCTION "$0
    if (NF > 2)
    {
      fline = "model_parameters::"$2
      for (i = 3; i <= NF; i++)
        fline = fline" "$i
    }
    else
    {
      fline = "void model_parameters::"$2"(void)"
    }
    openFunction(fline)
  # print "// SectionName: "sectionName
  # print "// fline: "fline
  }
  else
  {
    print $0
  }
}

END{
  print "// in END:"
  while (functionOpen >0)
     closeFunction()
  while (bracesOpen > 0)
     closeBraces()
  closeSection()
}


# define some functions

function closeSection()
{
  if ( (sectionName =="DATA_SECTION") ||
       (sectionName =="PARAMETER_SECTION"))
    print "};"
  while (groupOpen > 0)
  {
    closeGroup()
  }
}

function closeGroup()
{
  groupOpen = groupOpen - 1
  print "//@}  //" groupOpen " end " sectionName
}

function openSection(secName)
{
  print "\n"
  #if (secName != "")
  #{
  ##  print "/// \\defgroup " secName " " secName
      print "/// \\ingroup " secName
      sectionName = secName
  #}
  #else
  #  sectionName = "NULL"

  print "//@{  //" groupOpen
  groupOpen = groupOpen + 1
}


function openBraces()
{
    print "{"
    bracesOpen = bracesOpen + 1
}

function closeBraces()
{
  if (bracesOpen > 0)
  {
    print "}"
    --bracesOpen
  }
}

function openFunction(funcName)
{
# print "\n// openFunction: "funcName
  print funcName
  functionName=funcName
  ++functionOpen
  openBraces()
# print "// bracesOpen ",bracesOpen," functionOpen ",functionOpen
}

function closeFunction()
{
  closeBraces()
  print "// end of function",functionName
  functionName=""
  --functionOpen
}
