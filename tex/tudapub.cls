\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{tudapub}
	{\filedate}{\fileversion}{Publications using TU Darmstadt's Coporate Desing (TUDa-CI)}

\RequirePackage{l3keys2e}
\RequirePackage{URspecialopts}

\Define@specialopt@Module[TUDa/special]



\tl_new:N \g_TUDa_pub_class_tl
\tl_new:N \g_TUDa_thesis_options_tl

\prop_new:N \g_TUDa_clsopts_prop
\prop_new:N \g_TUDa_unknown_clsopts_prop 
\prop_gput:Nnn \g_TUDa_clsopts_prop {titlepage} {firstiscover}
\prop_gput:Nnn \g_TUDa_clsopts_prop {captions} {nooneline}

\int_new:N \g_TUDa_ruledheaders_int
\int_new:N \g_TUDa_paper_int

%Message Declaration for option processing
\msg_new:nnn {TUDaPub} {titlepage-option-disabled} {
	You~set~the~titlepage~option~to~#1.\\
	The~Corporate~Design~guidelines~for~TU~Darmstadt~do~not~support~this~option.\\
	The~KOMA-Script~option~titlepage~is~forced~to~"firstiscover".
}

\keys_define:nn {TUDa/pub} {
	%twoside -> geometry + class
	class .choice:,
	class/report .meta:n = {class=scrreprt},
	class/scrreprt .code:n  = \tl_gset:Nn \g_TUDa_pub_class_tl {scrreprt},
	class/article .meta:n = {class=scrartcl},
	class/scrartcl .code:n  = \tl_gset:Nn \g_TUDa_pub_class_tl {scrartcl},
	class/book .meta:n = {class=scrbook},
	class/scrbook .code:n  = \tl_gset:Nn \g_TUDa_pub_class_tl {scrbook},
	class .initial:n = scrartcl,%MAYBE add custom values
	color .meta:n = {accentcolor=#1},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	marginpar .tl_gset:N = \g_TUDa_marginpar_tl,
	marginpar .default:n = auto,
	marginpar .initial:n = auto,
	custommargins .bool_gset:N = \g_TUDa_custommargins_bool,
	custommargins .initial:n = false,
	custommargins .default:n = true,
	fontsize .code:n = \prop_gput:Nnn \g_TUDa_clsopts_prop {fontsize} {#1},
	fontsize .initial:n = {9pt},
	ruledheaders .choices:nn = {false, none, chapter, section, true,  all}{
		\int_gset:Nn \g_TUDa_ruledheaders_int {\l_keys_choice_int}
	},
	ruledheaders .initial:n = all,
	type .choices:nn = {publication, thesis} {\tl_gset_eq:NN \g_TUDa_pubType_tl \l_keys_choice_tl},
	type .initial:n = publication,
	unknown .code:n = {\prop_gput:NVn \g_TUDa_unknown_clsopts_prop \l_keys_key_tl {#1}},
	headline .choice:,
	headline / true .code:n = \bool_gset_true:N \g_TUDa_headline_bool, 
	headline / false .code:n = \bool_gset_false:N \g_TUDa_headline_bool, 
	headline / automark .code:n = {\bool_gset_true:N \g_TUDa_headline_bool \PassOptionsToPackage{automark}{scrlayer-scrpage}},
	automark .meta:n = {headline=automark},
	headline .initial:n =false,
	colorback .bool_gset:N = \g_TUDa_colorback_bool,
	colorback .initial:n = true,
	pdfa .bool_gset:N = \g_TUDa@pdfa_bool,
	pdfa .initial:n = true,
	twocolumn .bool_gset:N = \g_TUDa_twocolumn_bool,
	twocolumn .default:n = true,
	twocolumn .initial:n = false,
	BCOR .code:n = \PassOptionsToPackage{bindingoffset=#1}{geometry},
	bindingoffset .meta:n = {BCOR=#1},
	captions .code:n = {\prop_gput:Nnx \g_TUDa_clsopts_prop {captions} {	
		\use:n {\prop_item:Nn \g_TUDa_clsopts_prop {captions}}, #1}
	},
	abstract .code:n = \prop_gput:Nnn \g_TUDa_unknown_clsopts_prop {abstract} {#1},
	abstract .initial:n =true,
	logo .choice:,
	logo / head .code:n = {\bool_gset_true:N \g_TUDa_logo@inhead_bool},
	logo / body .code:n = {\bool_gset_false:N \g_TUDa_logo@inhead_bool},
	logo / top .code:n = {\bool_gset_true:N \g_TUDa_logo@inhead_bool},
	logo / bottom .code:n = {\bool_gset_false:N \g_TUDa_logo@inhead_bool},
	logo .initial:n = {body},
	titlepage .code:n = {\msg_warning:nnn {TUDaPub} {titlepage-option-disabled} {#1}},
	paper .choices:nn = {a0,a1,a2,a3,a4,a5,a6}{
		\int_gset_eq:NN \g_TUDa_paper_int  \l_keys_choice_int
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{typearea}
		\PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper .initial:n = a4,
	IMRAD .bool_gset:N = \g_TUDa_IMRAD_bool,
	IMRAD .initial:n = true,
	IMRAD .default:n = true,
	instbox .code:n = {\tl_gput_right:Nn \g_TUDa_thesis_options_tl {,instbox=#1}},
	noinstbox .code:n = {\tl_gput_right:Nn \g_TUDa_thesis_options_tl {,noinstbox=#1}},
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
}
%
%%special option handling grouped values
\Module@DefineSpecialKey[TUDa/special]{thesis}{
	\keys_set:nn {TUDa/pub}{type=thesis}
	\tl_gput_right:No \g_TUDa_thesis_options_tl {#1}
}

\Module@Process@SpecialOptions[TUDa/special]

\ProcessKeysOptions{TUDa/pub}



\bool_if:NT  \g_TUDa@pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}

\prop_gput:Nnx \g_TUDa_clsopts_prop {twocolumn} {\bool_if:NTF \g_TUDa_twocolumn_bool {true} {false}}

\prop_map_inline:Nn \g_TUDa_clsopts_prop {
	\tl_if_empty:nTF {#2} 
		{\PassOptionsToClass  {#1} {\g_TUDa_pub_class_tl}}
		{
		\clist_map_inline:nn {#2} {\PassOptionsToClass  {#1=##1} {\g_TUDa_pub_class_tl}}
		}
}


%Load tudasize clo file if available
\file_if_exist:nT {tudasize\prop_item:Nn \g_TUDa_clsopts_prop {fontsize}.clo}
	{\providecommand*{\@fontsizefilebase}{tudasize}}

%\PassOptionsToPackage{DIV=7}{typearea}

\LoadClass{\g_TUDa_pub_class_tl}

\prop_map_inline:Nn \g_TUDa_unknown_clsopts_prop {
	\cs_if_exist:cT {KV@KOMA.\g_TUDa_pub_class_tl.cls@#1} {
	\tl_if_empty:nTF {#2} 
		{\KOMAoptions{#1} }
		{\clist_map_inline:nn {#2} {\KOMAoptions{#1=##1}}}
	}
}

%ruled headers
\int_compare:nT {\g_TUDa_ruledheaders_int>=3} {
	\cs_if_exist:NT \chapterlinesformat {
		\renewcommand*{\chapterlinesformat}[3]{%
			\@hangfrom{#2}{#3}
			\smash{\raisebox{\depth}{\rule[\dp\strutbox]{\linewidth}{\g_TUDa_titlerule_dim}}}
		}
	}
}
\int_compare:nT {\g_TUDa_ruledheaders_int =4 }{
	\renewcommand*\sectionlinesformat[4]{%
		\tl_if_eq:nnTF {#1} {section} 
		{
		\parbox{\linewidth}{
		\rule[5\g_TUDa_titlerule_dim]{\linewidth}{\g_TUDa_titlerule_dim}\par\nointerlineskip
		\@hangfrom{%
			\hskip #2#3}{#4\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\TUDa_titlerule_sep: -\dp\strutbox}
		\smash{\rule{\linewidth}{\g_TUDa_titlerule_dim}}}
		}{
		\@hangfrom{\hskip #2#3}{#4}
		}
	}
}
\int_compare:nT {\g_TUDa_ruledheaders_int>4} {
	\renewcommand*\sectionlinesformat[4]{%
	\parbox{\linewidth}{
		\rule[5\g_TUDa_titlerule_dim]{\linewidth}{\g_TUDa_titlerule_dim}\par\nointerlineskip
		\@hangfrom{%
			\hskip #2#3}{#4\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
			\skip_vertical:n {\TUDa_titlerule_sep: -\dp\strutbox}
		\smash{\rule{\linewidth}{\g_TUDa_titlerule_dim}}
	}}
}
	

\usepackage{tudarules}


%,~ subsection,~ 


%\newcommand{\chapterlineswithprefixformat}[3]{%
%	#2#3%
%}
%
%ngerman,article,dr=phil,type=drfinal,colorback,accentcolor=TUDa-9c, fontsize=9pt,twoside=true

\usepackage{tudafonts}

%Margin & titlefontsize setup setup
\bool_new:N \g_TUDa_marginpar_bool

\dim_new:N \g_TUDa_marginpar_dim
\dim_new:N \g_TUDa_innerMargin_dim
\dim_new:N \g_TUDa_outerMargin_dim
\dim_new:N \g_TUDa_bottomMargin_dim
\dim_new:N \g_TUDa_topMargin_dim


	%a3,a4
	\int_compare:nTF {4<=\g_TUDa_paper_int<=5}
	{
		\dim_gset:Nn \g_TUDa_bottomMargin_dim {20mm}
		\dim_gset:Nn \g_TUDa_outerMargin_dim {15mm}
		\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
		\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
	}{
	%a0, a1, a2
		\int_compare:nT {1<=\g_TUDa_paper_int<=3}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {35mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {30mm}
			\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
		%a5
		\int_compare:nT {\g_TUDa_paper_int<=6}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {16mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {12mm}
			\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
		%a6
		\int_compare:nT {\g_TUDa_paper_int<=7}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {15mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {10mm}
			\dim_gset_eq:NN	 \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
	}

%TODO pubched
%%punched
%\dim_gset:Nn \g_TUDa_outerMargin_dim {15mm}
%\dim_gset:Nn \g_TUDa_innerMargin_dim {20mm}
%\if@twoside
%\else
%\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
%\fi

\dim_new:N \g_TUDa_columnSep_dim
\dim_gset:Nn \g_TUDa_columnSep_dim {10pt}

%coverpage
\edef\coverpageleftmargin{\dim_eval:n {\g_TUDa_outerMargin_dim}}
\renewcommand*{\coverpagetopmargin}{\g_TUDa_outerMargin_dim}
\edef\coverpagerightmargin{\dim_eval:n {\g_TUDa_outerMargin_dim}}
\renewcommand*{\coverpagebottommargin}{\g_TUDa_outerMargin_dim}

\str_case:onTF {\g_TUDa_marginpar_tl} {
	{true} {\bool_gset_true:N \g_TUDa_marginpar_bool}
	{false} {\bool_gset_false:N \g_TUDa_marginpar_bool}
	{auto} {\bool_gset_true:N \g_TUDa_marginpar_bool}
} {
	\bool_if:NT  \g_TUDa_marginpar_bool {
		\msg_new:nnnn {TUDa} {marginpar-auto} {Setting~up~marginpar~consistent~with~layout~guidelines.} {To~turn~this~off~use~marginpar=false~option.}
		\msg_info:nn {TUDa} {marginpar-auto}
		\dim_gset:Nn \g_TUDa_marginpar_dim {(\paperwidth - \g_TUDa_innerMargin_dim -\g_TUDa_outerMargin_dim - 4  \g_TUDa_columnSep_dim)/5}
	}
} {
	\msg_new:nnn {TUDa} {marginpar-no-key} {I~did~not~find~a~text~key~for~marginpar~setup~will~use~the~value~#1~as~width.}
	\msg_info:nnx {TUDa} {marginpar-no-key} {\g_TUDa_marginpar_tl}
	\bool_gset_true:N \g_TUDa_marginpar_bool
	\dim_gset:Nn \g_TUDa_marginpar_dim {\g_TUDa_marginpar_tl}
} 


\dim_new:N \g_TUDa_headheight_dim
\dim_new:N \g_TUDa_headwidth_dim

\bool_if:NTF \g_TUDa_headline_bool
	{\dim_gset:Nn \g_TUDa_headheight_dim {20pt +\c_TUDa_largerule_dim +\c_TUDa_rulesep_dim +\c_TUDa_smallrule_dim}}
	{\dim_gset:Nn \g_TUDa_headheight_dim {1.25\baselineskip +\c_TUDa_largerule_dim +\c_TUDa_rulesep_dim +\c_TUDa_smallrule_dim}}

%%%%%Anfang Randeinstellungen Geometry

\bool_if:NTF  \g_TUDa_custommargins_bool {
	\KOMAoptions{headinclude, footinclude}
	\let\TUDa_disable_marginpar:\relax
	\let\TUDa_restore_typearea:\relax
}{
	\RequirePackage[top=\g_TUDa_topMargin_dim, inner=\g_TUDa_innerMargin_dim, outer=\dim_eval:n {\g_TUDa_outerMargin_dim}, bottom=\g_TUDa_bottomMargin_dim, columnsep= \g_TUDa_columnSep_dim, includehead, includefoot,includemp, nomarginpar, headheight=\g_TUDa_headheight_dim
	]{geometry}


	\savegeometry{TUDa@nomarginpar}
	\geometry{includemp, marginpar=\g_TUDa_marginpar_dim, marginparsep=\g_TUDa_columnSep_dim}
	\KOMAoptions{mpinclude}
	\savegeometry{TUDa@marginpar}
	\bool_if:NTF  \g_TUDa_marginpar_bool {
		\loadgeometry{TUDa@marginpar}
		\tl_const:Nn \c_TUDa_default_geometry_tl {TUDa@marginpar}
	}  {
		\loadgeometry{TUDa@nomarginpar}
		\tl_const:Nn \c_TUDa_default_geometry_tl {TUDa@nomarginpar}
	}


	\dim_gset:Nn \g_TUDa_headwidth_dim 			  {\paperwidth-\g_TUDa_innerMargin_dim-\g_TUDa_outerMargin_dim-\Gm@bindingoffset}
	
	\cs_set:Nn \TUDa_disable_marginpar: {\loadgeometry{TUDa@nomarginpar}}
	\cs_set:Nn \TUDa_restore_typearea: {\loadgeometry{\c_TUDa_default_geometry_tl}}

}



%%%%%%%%
%Ende Randeinstellungen klassisch

\usepackage[draft=false]{scrlayer-scrpage}


\newcommand*{\institution}[1]{
	\def\TUDa@institution{#1}
}

\gdef\datename{Datum}
\gdef\dateseparator{:~}




\setkomafont{disposition}{\sffamily\bfseries}



\dim_new:N \g_TUDa_titlerule_dim
\dim_gset:Nn \g_TUDa_titlerule_dim {.5\c_TUDa_smallrule_dim}

%\dim_new:N \g_TUDa_titlerule_sep_dim
%\dim_set:Nn \g_TUDa_titlerule_sep_dim {1ex}
\cs_new:Nn \TUDa_titlerule_sep: {\the\dp\strutbox}

\usepackage{tudacolors}

%TODO: mode -> light head. 

\setkomafont{pageheadfoot}{\sffamily\small}
\setkomafont{pagenumber}{}


\KOMAoptions{footsepline=.5\c_TUDa_smallrule_dim}
\bool_if:NT \g_TUDa_headline_bool {\KOMAoptions{headsepline=.5\c_TUDa_smallrule_dim}}

%Adjust headheight
\AtBeginDocument{
\KOMAoptions{headlines=1.5}
\recalctypearea
}

\newpairofpagestyles[scrheadings]{TUDa.headings}{
	\KOMAoptions{headsepline, headlines=1.25, footlines=1.25}
	\setkomafont{pagehead}{}
	\ohead{\headmark}
}

\newpairofpagestyles{TUDa}{
	\KOMAoptions{
		plainfootsepline}
	
	\bool_if:NTF \g_TUDa_marginpar_bool 
		{
		\KOMAoptions {
			headwidth=textwithmarginpar,
			footwidth=textwithmarginpar
			}
		}{
		\KOMAoptions {
			headwidth=text,
			footwidth=text
			}
		}

\setkomafont{pagehead}{\Large\bfseries}
\box_if_exist:NF \TUDa@headline_box {
	\TUDa@makeheadrule[color=identbarcolor, width=\sls@headwidth]{TUDa@headline}
}
	\if@twocolumn
	\edef\sls@evenheadshift{\dim_eval:n {-\marginparwidth-\marginparsep\relax}}
	\let\sls@oddheadshift\sls@evenheadshift
	\let\sls@evenfootshift\sls@evenheadshift
	\let\sls@oddfootshift\sls@evenheadshift
	\fi
	\ModifyLayer[
		background,
		contents={\smash{\TUDa@headline}}
	]{TUDa.head.above.line}	
	\ModifyLayer[
		background,
		contents={\smash{\TUDa@headline}}
	]{plain.TUDa.head.above.line}
	\bool_if:NT \g_TUDa_headline_bool {
		\clist_map_variable:nNn {oneside, even, odd} \l_tmpa_tl {
			\ModifyLayer[pretocontents={\rule[-6pt]{0pt}{\layerheight}}]{TUDa.head.\l_tmpa_tl}
		}
		\lehead{\headmark}
		\lohead{\headmark}
	}
	\ofoot[\pagemark]{\pagemark}
}

\cs_new:Nn \TUDa_sls@leftmargin: {%
	\dimexpr
	\if@twoside
	\ifodd\value{page}
	\oddsidemargin
	\else
	\evensidemargin
	\fi
	\else
	\oddsidemargin
	\fi
	\bool_if:NT \g_TUDa_twocolumn_bool {
	-\marginparwidth-\marginparsep
	}
	+1in\relax
}

\pagestyle{TUDa}

%Titelseite
\tl_new:N  \g_TUDa_titleimage_code_tl
\tl_gset_eq:NN  \g_TUDa_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_TUDa_titleimage_code_tl {#1}}

\box_new:N  \g_TUDa_title_box 
\skip_new:N \g_TUDa_title_fill_skip

\renewcommand{\titlepagestyle}{title.TUDa}


\seq_new:N \g_TUDa_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_TUDa_author_seq {\and} {#1}
}

\msg_new:nnn {TUDaPub} {unknown-language} {
	You~selected~an~unknown~language~#1.\\
	The~Variable~#2~does~not~have~a~predefined~value.\\
	Ensure~to~redefine~#2~to~match~your~language.\\
	Otherwise~the~ngerman~vaue~#3~will~be~used.
}

\cs_new:Nn \TUDa_define_captionFallback:Nn {
	\providecommand*#1{
	\msg_warning:nnxxx {TUDaPub} {unknown-language}
		{\languagename} {\exp_not:N #1} {#2}
	\def#1{#2}
	}
}

\renewcommand*{\@author}{
	\seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\&~}
}

\msg_new:nnn {TUDaPub} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}

\exp_args:NV \tl_if_eq:nnTF {\g_TUDa_pubType_tl}  {thesis} {
	\input{tudathesis.cfg}
} {

\msg_new:nnnn {TUDa/pub} {only-thesis} {You~tried~to~use~\use:c { #1}.~This~macro~is~only~available~for~publications~of~type~thesis}{See~tuda-ci~documentation~for~further~information}

\clist_map_inline:nn {birthplace, group, examdate, submissiondate, tuprints, urn, reviewer} {
	\expandafter\newcommand\csname #1\endcsname[2][]{
		\msg_error:nnn {TUDa/pub} {only-thesis} {#1}
	}
}
\newcommand*{\TUDa@title@footnote}[2][1]{
\textsuperscript{\@fnsymbol{#1}}#2
}




\renewcommand*{\maketitle}[1][1]{
	\def\and{,~ }
	\cs_if_exist_use:N \TUDa_pass_TitleData:
	\TUDa_disable_marginpar:
	\cleardoublepage
	\begin{titlepage}
		\setcounter{page}{%
			#1%
		}%
		\def\thefootnote{\fnsymbol{footnote}}
		\if@titlepageiscoverpage
		\edef\titlepage@restore{%
			\noexpand\endgroup
			\noexpand\global\noexpand\@colht\the\@colht
			\noexpand\global\noexpand\@colroom\the\@colroom
			\noexpand\global\vsize\the\vsize
			\noexpand\global\noexpand\@titlepageiscoverpagefalse
			\noexpand\let\noexpand\titlepage@restore\noexpand\relax
		}%
		\begingroup
		\topmargin=\dimexpr \coverpagetopmargin-1in\relax
		\oddsidemargin=\dimexpr \coverpageleftmargin-1in\relax
		\evensidemargin=\dimexpr \coverpageleftmargin-1in\relax
		\textwidth=\dimexpr
		\paperwidth-\coverpageleftmargin-\coverpagerightmargin\relax
		\textheight=\dimexpr
		\paperheight-\coverpagetopmargin-\coverpagebottommargin\relax
		\headheight=0pt
		\headsep=0pt
		\footskip=\baselineskip
		\@colht=\textheight
		\@colroom=\textheight
		\vsize=\textheight
		\columnwidth=\textwidth
		\hsize=\columnwidth
		\linewidth=\hsize
		\else
		\let\titlepage@restore\relax
		\fi
		\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
		\hbox_gset:Nn \g_TUDa_title_box {
			\parbox[t]{\linewidth}{
				\begin{minipage}[b]{\bool_if:NT \g_TUDa_logo@inhead_bool {.75}\linewidth}
					\begin{addmargin}{3mm}
						\raggedright
						\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
						\leavevmode\usekomafont{title}%
						\expandafter\fontsize\TUDa_title_fontsize:
						\selectfont
						\@title\strut\par
						\vskip0pt
					\end{addmargin}
				\end{minipage}%
				\par\nointerlineskip
				\rule{\linewidth}{\g_TUDa_titlerule_dim}\par
				\begin{addmargin}{3mm}
					\expandafter\fontsize\TUDa_titleinfo_fontsize:
					\selectfont
					{\ifx\@subtitle\@empty\else\usekomafont{subtitle}{\@subtitle\par}\fi}%
					{\ifx\@subject\@empty\else\usekomafont{subject}{\@subject\par}\fi}
					{%
						\usekomafont{author}
						\lineskip 0.75em
						\@author
						\par
					}%
					{\usekomafont{date}{\@date\par}}%
					{\usekomafont{publishers}{\@publishers \par}}%
				\end{addmargin}
			\tl_if_empty:NF \@thanks {
			\expandafter\fontsize\TUDa_titlethanks_fontsize:\selectfont\par
			\rule{\linewidth}{\g_TUDa_titlerule_dim}\par
			\begin{addmargin}{3mm}
				\let\footnotetext\TUDa@title@footnote
				\@thanks
			\end{addmargin}
				\par\vspace{-\dp\strutbox}
				\let\@thanks\@empty
			}
			\rule{\linewidth}{\g_TUDa_titlerule_dim}\par}
		
		}
			
		\TUDa_adjust_titlepage_style:
		

		\nointerlineskip\box_use:N \g_TUDa_title_box
		\par
		\vfill\null
		\if@twoside
		\@tempswatrue
		\expandafter\ifnum \@nameuse{scr@v@3.12}>\scr@compatibility\relax
		\else
		\ifx\@uppertitleback\@empty\ifx\@lowertitleback\@empty
		\@tempswafalse
		\fi\fi
		\fi
		\if@tempswa
		\next@tpage
		\begin{minipage}[t]{\textwidth}
			\@uppertitleback
		\end{minipage}\par
		\vfill
		\begin{minipage}[b]{\textwidth}
			\@lowertitleback
		\end{minipage}\par
		\@thanks\let\@thanks\@empty
		\fi
		\fi
		\ifx\@dedication\@empty
		\else
		\next@tdpage\null\vfill
		{\centering\usekomafont{dedication}{\@dedication \par}}%
		\vskip \z@ \@plus3fill
		\@thanks\let\@thanks\@empty
		\cleardoubleemptypage
		\fi
		\ifx\titlepage@restore\relax\else\clearpage\titlepage@restore\fi
	\end{titlepage}
	\setcounter{footnote}{0}%
	\global\let\and\relax
	\cleardoublepage
	\TUDa_restore_typearea:
	\aftergroup\TUDa_restore_typearea:
}


}

\cs_set:Nn 	\TUDa_adjust_titlepage_style: {
	\dim_set:Nn \l_tmpa_dim {\fp_to_dim:n {\expandafter \use_ii:nn\TUDa_title_fontsize: *2.8}}
	\dim_compare:nT  {\box_ht:N \g_TUDa_title_box < \l_tmpa_dim} {
		\skip_set:Nn \g_TUDa_title_fill_skip {\dim_eval:n {\l_tmpa_dim -  \box_ht:N \g_TUDa_title_box}}
	}

	\dim_set:Nn \l_tmpa_dim {
		\box_ht:N \TUDa@headline_box+\box_dp:N \TUDa@headline_box-\g_TUDa_titlerule_dim
		+\box_ht:N \g_TUDa_title_box+.5\c_TUDa_logoheight_dim+\g_TUDa_title_fill_skip+
		\box_dp:N \g_TUDa_title_box
	}

	\ModifyLayer[
		addvoffset=\l_tmpa_dim,
		addheight=-\l_tmpa_dim
	]{title.TUDa.image}

	\bool_if:NT \g_TUDa_logo@inhead_bool {
		\ModifyLayer[
		addvoffset=\dim_eval:n {\box_ht:N \TUDa@headline_box+\box_dp:N \TUDa@headline_box-\g_TUDa_titlerule_dim},
		height={\box_ht:N \g_TUDa_title_box+ \g_TUDa_title_fill_skip+.5\c_TUDa_logoheight_dim}
		]{title.TUDa.background}
		
		\AddLayersToPageStyle{title.TUDa}{title.TUDa.background}
	}



	\thispagestyle{title.TUDa}

	\vspace*{\dim_eval:n {
		-\topskip
		-\g_TUDa_titlerule_dim
		+\box_ht:N \TUDa@headline_box
		+\box_dp:N \TUDa@headline_box
		+.5\c_TUDa_logoheight_dim
	}}
	\nointerlineskip
	\TUDa_Setup_Title_box:
	
	\bool_if:NT \g_TUDa_logo@inhead_bool {
		\dim_compare:nT {\box_ht:N \g_TUDa_title_info_box+ \box_dp:N \g_TUDa_title_info_box  > \box_ht:N \g_TUDa_title_box} 
			{\msg_warning:nn {TUDaPub} {infobox-too-high}}
		\makebox[\linewidth][r]{\smash{
				\raisebox{-\height}{
					\makebox[2.2\c_TUDa_logoheight_dim][l]{
						%				}
						\box_use:N \g_TUDa_title_info_box
				}}
		}}
	}
	\par
	\vspace*{\skip_use:N \g_TUDa_title_fill_skip}
	\setlength{\fboxsep}{\z@}
}


\newkomafont{institution}{\sffamily}
\setkomafont{subtitle}{\bfseries}
\setkomafont{subject}{}
\setkomafont{publishers}{}
\setkomafont{author}{}
\setkomafont{date}{}

%TODO finish font setup

\int_case:nn {\g_TUDa_paper_int}
{
	%paper=a0
	{1} {
		\cs_set:Nn \TUDa_title_fontsize: {{125pt}{165pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{42pt}{55pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{28pt}{35pt}}
	}
	%paper=a1
	{2} {
		\cs_set:Nn \TUDa_title_fontsize: {{86pt}{120pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{35pt}{42pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{22pt}{26pt}}
	}
	%paper=a2
	{3} {
		\cs_set:Nn \TUDa_title_fontsize: {{65pt}{82pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{22pt}{28pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{14pt}{20pt}}
	}
	%paper=a3
	{4} {
		\cs_set:Nn \TUDa_title_fontsize: {{47pt}{61pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{16pt}{20pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{12pt}{16pt}}
	}
	%paper=a4
	{5} {
		\cs_set:Nn \TUDa_title_fontsize: {{36pt}{47pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{12pt}{14pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{10pt}{11.5pt}}
	}
	%paper=a5
	{6} {
		\cs_set:Nn \TUDa_title_fontsize: {{22pt}{28pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{11pt}{12pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{10pt}{11.5pt}}
	}
	%paper=a6
	{7} {
		\cs_set:Nn \TUDa_title_fontsize: {{14pt}{16pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{9pt}{10pt}}	
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{9pt}{10pt}}
	}
}



\seq_new:N \g_TUDa_title_info_seq 
\box_new:N \g_TUDa_title_info_box

\colorlet{TUDa@InfoBoxColor}{white}

\cs_new:Nn \TUDa_make_title_info_box:n {
	\setlength{\fboxsep}{1.5mm}%
	\colorbox{TUDa@InfoBoxColor}{
	\makebox[\dim_eval:n {2.2\c_TUDa_logoheight_dim-\fboxsep}][r]{
		\parbox{2\c_TUDa_logoheight_dim}{
		\expandafter\fontsize\TUDa_titlethanks_fontsize:\selectfont\usekomafont{institution}%
		\raggedright%
	#1
	}}}
}

\cs_new:Nn \TUDa_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}%
	\parbox{2.2\c_TUDa_logoheight_dim}{
		\colorbox{TUDa@InfoBoxColor}{
			\rlap{
			\makebox[2.5\c_TUDa_logoheight_dim][r]{
			\colorbox{TUDa@InfoBoxColor}{#1\hspace{.3\c_TUDa_logoheight_dim}}
			}
			}
		}
	}
}

\newcommand{\addTitleBox}[1]{\seq_gput_right:Nn \g_TUDa_title_info_seq {\TUDa_make_title_info_box:n {#1}}}

\NewDocumentCommand{\addTitleBoxLogo}{sm}{
	\IfBooleanTF{#1}{
		\seq_gput_right:Nn \g_TUDa_title_info_seq {
			\TUDa_make_title_logo_box:n {#2}
		}
	}{
		\seq_gput_right:Nn \g_TUDa_title_info_seq {
		 \TUDa_make_title_logo_box:n {
			\hbox_set:Nn \l_tmpa_box {
				\includegraphics[width=1.5\c_TUDa_logoheight_dim]{#2}
			}
			\dim_set:Nn \l_tmpa_dim {2\c_TUDa_logoheight_dim/3}
			\dim_compare:nTF {\box_ht:N \l_tmpa_box > \l_tmpa_dim}
			{\includegraphics[width=\l_tmpa_dim]{#2}}
			{\box_use:N \l_tmpa_box} 
	 	}
		}
	}
}

\addTitleBoxLogo*{\makebox[\linewidth][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}}

\DeclareNewLayer[textarea,background,mode=picture,
	contents={
		\tl_if_empty:NTF \g_TUDa_titleimage_code_tl 
		{\bool_if:NT \g_TUDa_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}}
		{\putUL{\color{identbarcolor}\raisebox{-\height}{\parbox[t]{\textwidth}{
					\let\width\layerwidth
					\let\height\layerheight
					\g_TUDa_titleimage_code_tl
					}}}}
		\bool_if:NF \g_TUDa_logo@inhead_bool {
			\put(\dim_to_decimal_in_unit:nn {\layerwidth-2.2\c_TUDa_logoheight_dim
			} {\unitlength},
			\dim_to_decimal_in_unit:nn {\layerheight-\box_ht:N \g_TUDa_title_info_box - .5\c_TUDa_logoheight_dim} {\unitlength}){	
				\rlap{\box_use:N \g_TUDa_title_info_box}
			}
		}
		\put(0,0){\rule{\linewidth}{\g_TUDa_titlerule_dim}}
	}              
]{title.TUDa.image}

\DeclareNewLayer[textarea,background,mode=picture,
contents={\color{identbarcolor}\rule{\layerwidth}{\layerheight}}
]{title.TUDa.background}


\DeclareNewLayer[
	mode=picture,
	align=tl,
	hoffset=\coverpageleftmargin,
	voffset=\coverpagetopmargin,
	width=\paperwidth-\coverpageleftmargin-\coverpagerightmargin,
	contents={
		\box_if_exist:NF \TUDa@title_headline_box
		{\TUDa@makeheadrule[color=identbarcolor, width=\layerwidth]{TUDa@title_headline}}
		\putUL{\TUDa@title_headline}
	}
]{title.TUDa.rule}

\cs_new:Nn \TUDa_Setup_Title_box: {
	\hbox_gset:Nn \g_TUDa_title_info_box
	{
		\parbox{\dimexpr2.5\c_TUDa_logoheight_dim}{
		\seq_use:Nn \g_TUDa_title_info_seq  {\par\nointerlineskip\vspace{5mm}}
		}
	}
}

\DeclareNewPageStyleByLayers{title.TUDa}{title.TUDa.rule,title.TUDa.image}

%Logos
\RequirePackage{graphicx}

\if_bool:N \g_TUDa@pdfa_bool

	\msg_new:nnn {TUDaPub} {prefer-lualatex} {
	You use pdfa-mode in #1.
	This can lead to incompatiblities especially with older compiler versions.
	You should prefer compiling using lualatex.
	}


	\PassOptionsToPackage{a-1b}{pdfx}
	\RequirePackage{pdfx}
	
	\sys_if_engine_pdftex:T {
		\msg_warning:nnn {TUDaPub} {prefer-lualatex} {PDFTeX}
	}
	
	\sys_if_engine_pdftex:T {
		\msg_warning:nnn {TUDaPub} {prefer-lualatex} {XeTeX}
	}
	


	\@ifpackagelater{pdfx}{2018/12/01}{
	}{
		\msg_new:nnnn {TUDaPub} {outdated-pdfx} {
			Your~Version~of~the~PDFx-package~is~too~old~to~support~all~methods~required~by~tudapubs~pdfa-mode.\\
			Either~update~your~TeX-distribution~or~switch~to~pdfa=false.
		}{See~DEMO-TUDaPub~for~further~information.}
		\msg_error:nn {TUDaPub} {outdated-pdfx}
	}
	
	
	%%hyperref
	\hypersetup{hidelinks, unicode}
	\iow_new:N \TUDa@xmpdata_stream
	\tl_new:N \g_TUDa@xmp_title_tl
	\tl_new:N \g_TUDa@xmp_author_tl
	
	\cs_if_exist:NF \prop_gput_if_new:Nnx {
	\cs_generate_variant:Nn \prop_gput_if_new:Nnn {Nnx}
	}

	\cs_if_exist:NF \tl_to_str:V {\cs_generate_variant:Nn \tl_to_str:N {V}}
	
	\cs_new:Nn \TUDa_pass_TitleData: {
		\iow_open:Nn \TUDa@xmpdata_stream {\jobname.xmpdata}
		\begingroup
		\def\newline{}
		\def\\{}
		\let\thanks\use_none:n
		\cs_set:Npn \and {\exp_not:n {\exp_not:N \sep}}
		\use:c {Hy@pdfstringtrue}
		\tl_gset:Nf \g_TUDa@xmp_title_tl {\@title}
		\prop_gput_if_new:Nnx \g_TUDa_MetaData_prop {title} {\tl_to_str:V \g_TUDa@xmp_title_tl}
		\tl_gset:Nf \g_TUDa@xmp_author_tl {\@author}
		\prop_gput_if_new:Nnx \g_TUDa_MetaData_prop {author} {\tl_to_str:V \g_TUDa@xmp_author_tl}
		\prop_gput_if_new:Nnn \g_TUDa_MetaData_prop {publisher}{TU~Darmstadt}
		\prop_gput_if_new:Nnn \g_TUDa_MetaData_prop {creator}{LaTeX~using~TUDa-CI}
		\use:c {pdfx@localcommands}%should be held inside group
		\prop_map_function:NN \g_TUDa_MetaData_prop  \TUDa_write_xmp_line:nn
	\endgroup
	\iow_close:N \TUDa@xmpdata_stream
	}
	\cs_new:Nn \TUDa_write_xmp_line:nn {	
		\begingroup
		\cs_set:Npn \sep {\exp_not:N \sep}
		\cs_if_exist:cTF {\tl_mixed_case:n {#1}} {
			\iow_now:Nx \TUDa@xmpdata_stream {
				\c_backslash_str \tl_mixed_case:n {#1} {#2}
			}
		}{
			\msg_error:nnn {TUDaPub} {unknown-metadata} {#1}
		}
		\endgroup
	}

\prop_new:N \g_TUDa_MetaData_prop
	
	\newcommand*{\Metadata}[1]{
		\keyval_parse:NNn  \use_none:n \TUDa_set_metadata_prop:nn 
		{#1}
	}
	
	\cs_set:Nn \TUDa_set_metadata_prop:nn {
	\exp_args:NNf \prop_gput:Nnn \g_TUDa_MetaData_prop {\tl_lower_case:n{#1}}  {#2}
	}
	
	\msg_new:nnnn {TUDaPub} {unknown-metadata} {
	You~ used~ the~ #1~ metadata~ entry.\\
	I~ don't~ know~ how~ to~ handle~ that.\\
	It~ will~ be~ ignored.
	} {See~ TUDa-CI~ or~ pdfx~ documentation~ for~ details.}
\else:
	\msg_new:nnn {tudaPub} {no-pdfa}{The~ tudapub~ class~ won't~ create~ PDF/A-mode.}
	\msg_info:nn {tudaPub} {no-pdfa}
	%%hyperref
	\RequirePackage[hidelinks, unicode]{hyperref}
	
	\newcommand{\Metadata}[1]{\ClassError{tudapub}{You~cannot~use~\string\Metadata\ ~with~pdfa=false.}{}}
\fi:

%%Abstract anpassungen mit Sprache
\providecommand{\abstract}{}% für book
\RenewDocumentEnvironment{abstract}{o}{
	\begingroup
	\IfNoValueF{#1}{\selectlanguage{#1}}
	\bool_set_true:N \l_tmpa_bool
	\cs_if_exist:NT \if@abstrt {
		\if@abstrt
		\else
		\bool_set_false:NT \l_tmpa_bool
		\fi
	}
	\bool_if:NT \l_tmpa_bool {
		\scr@ifundefinedorrelax{chapter}{%
			\iftocfeature{toc}{leveldown}
			{\subsection*}
			{\section*}
		}{
			\iftocfeature{toc}{leveldown}
			{\section*}
			{\chapter*}
		} {\abstractname}
		
}}{
	\endgroup
}


%Anpassungen marginpar
\cs_set_eq:NN\TUDa_orig@marginpar:\marginpar
\newkomafont{marginpar}{\color{textaccentcolor}\accentfont}
\RenewDocumentCommand{\marginpar}{om}{
	\IfNoValueTF{#1}{
		\TUDa_orig@marginpar:{\usekomafont{marginpar}#2}
	}{
		\TUDa_orig@marginpar:[\usekomafont{marginpar}#1]{\usekomafont{marginpar}#2}
	}
}

\TUDa_define_captionFallback:Nn \authorandname {and}
\defcaptionname{ngerman, german}{\authorandname}{und}
\defcaptionname{english, USenglish, american, UKenglish, british}{\authorandname}{and}


\providecommand*{\frontmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmattertrue 
	\pagenumbering {roman}
}

\providecommand*{\mainmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmattertrue 
	\pagenumbering {arabic}
}

\providecommand*{\backmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmatterfalse
}


%IMRAD:Introduction 
\seq_if_exist:NTF \seq_const_from_clist:Nn {
	\seq_const_from_clist:Nn \c_TUDa_IMRAD_seq {introduction, methods, results, discussion}
} {
	\seq_new:N \c_TUDa_IMRAD_seq
	\seq_gset_from_clist:Nn \c_TUDa_IMRAD_seq {introduction, methods, results, discussion}
}

\newcommand*{\IMRADlabel}[1]{
	\seq_if_in:NnTF \c_TUDa_IMRAD_seq  {#1}
		{\label{IMRAD:#1}}
		{\msg_error:nnnn {TUDaPub}{undefined-IMRADlabel}{#1}{\seq_use:Nn \c_TUDa_IMRAD_seq {,}}}
}


\bool_if:NT \g_TUDa_IMRAD_bool {
	\AtEndDocument{
		\seq_map_inline:Nn \c_TUDa_IMRAD_seq {
			\cs_if_exist:cF {r@IMRAD:#1} {
			\msg_warning:nnn {TUDaPub}{missing-IMRADlabel} {#1}
			}	 
	 	}
	}
}

\msg_new:nnn {TUDaPub}{undefined-IMRADlabel} {
	You~tried~to~set~an~IMRAD~label~with~key~#1.\\
	This~label~type~is~not~declared.\\
	Possible~labels~are:~#2
}


\msg_new:nnn {TUDaPub} {missing-IMRADlabel} {
	You~did~not~provide~a~Label~for~key~#1.\\
	Either~you~need~to~recompile~your~document~or~add~a~label~using~\string\IMRADlabel.
}


\endinput
%End of class tudapub.cls
