# TUDa-CI – Corporate Design LaTeX-Templates for TU Darmstadt

 Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2019

 tuda-ci 2019/08/05 v1.01

***************************************************************************

 This material is subject to the LaTeX Project Public License version 1.3c
 or later. See http://www.latex-project.org/lppl.txt for details.

***************************************************************************

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

[English version below](#summary)

# Zusammenfassung
Das TUDa-CI-Bundle ist die Umsetzung des Corporate Designs der TU Darmstadt in LaTeX.
Es liefert neben den Klassen-, Paket- und Konfigurationsdateien auch Anwenderdokumentation in Form von Templatedateien für verschiedene Dokumententypen.

Das Gesamtpaket wurde in Teilen inspiriert von Clemens von Loewenichs and Joe Werners TUD-Design Paket.

Derzeit existieren diese Templates nur in Deutscher Sprache.
 
## Verwendungshinweis
Die Richtlinien des Corporate Designs, sowie die Anforderungen der Universitätsbibliothek erfordern einige spezielle Konfigurationen. Beispielsweise ist für wissenschaftliche Veröffentlichungen und Abschlussarbeiten die Erzeugung einer archivierbaren PDF-Datei (PDF/A) vorgesehen.
Dies ist mit aktuellen LaTeX-Paketen und dem Compiler LuaLaTeX deutlich konsequenter umzusetzen.
Aus diesem Grund wird empfohlen, die verwendete Distribution vorab zu aktualisieren und LuaLaTeX zu verwenden.
Weitere Hinweise finden sich in den Beispieldateien dokumentiert.

## Installation
Für die Verwendung der Klassen und Pakete muss entweder der gesamte Inhalt des tex-Verzeichnisses im Arbeitsverzeichnis liegen oder in der TeX-Distribution installiert werden. Dies ist entweder über die Paketverwaltung der Distribution möglich oder das Paket kann manuell mithilfe der Release Informationen im GitHub Repository installiert werden.

### Logos & verwendete Bilddateien
Die verwendeten Logos sind nicht Bestandteil dieses Bundles und können von Mitgliedern der TU Darmstadt über das interne Netzwerk heruntergeladen werden. 

https://download.hrz.tu-darmstadt.de/protected/CE/TUDa_LaTeX/tuda_logo.pdf

Für die Permanente Installation der Logodateien findet sich unter 
https://www.ce.tu-darmstadt.de/ce/latex_tuda/index.de.jsp
ein Paket mit entsprechenden Hinweisen.

Für Nicht-Mitglieder ist eine Möglichkeit zur Platzierung eines Ersatzlogos dokumentiert.

## Enthaltene Templatedateien

Dokumententyp | Templatedatei(en) | Dokumentenklasse
------------- | ----------------- | ----------------
Wissenschaftliche Artikel | DEMO-TUDaPub.tex, verwendet auch DEMO-TUDaBibliography.bib | tudapub.cls mit tudasize9pt.clo
Abschlussarbeiten | DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, verwendet auch DEMO-TUDaBibliography.bib | tudapub.cls mit tudathesis.cfg
Wissenschaftliche Poster | DEMO-TUDaSciPoster.tex | tudasciposter.cls
Veranstaltungsankündigungen | DEMO-TUDaPoster.tex | tudaposter.cls
Präsentationen | DEMO-TUDaBeamer.tex | tudabeamer.cls
Briefe | DEMO-TUDaLetter.tex, verwendet auch DEMO-TUDaFromaddress.lco  | tudaletter.cls mit tudalettersize10pt.clo

## Liste aller enthaltenen Dateien:

* README.md
* demo/
  - DEMO-TUDaBeamer.tex
  - DEMO-TUDaBibliography.bib
  - DEMO-TUDaLetter.tex
  - DEMO-TUDaPhD.tex
  - DEMO-TUDaPoster.tex
  - DEMO-TUDaPub.tex
  - DEMO-TUDaSciPoster.tex
  - DEMO-TUDaThesis.tex
  - TuDa_Demo.lco
* tex/
  - tudabeamer.cls
  - beamercolorthemeTUDa.sty
  - beamerfontthemeTUDa.sty
  - beamerinnerthemeTUDa.sty
  - beamerouterthemeTUDa.sty
  - beamerthemeTUDa.sty
  - tudacolors.cfg
  - tudacolors.def
  - tudacolors.sty
  - tudafonts.sty
  - tudaletter.cls
  - tudalettersize10pt.clo
  - tudaposter.cls
  - tudapub.cls
  - tudarules.sty
  - tudasciposter.cls
  - tudasize9pt.clo
  - tudathesis.cfg



# Summary

The TUDa-CI-Bundle provides a possibility to use the Corporate Design of TU Darmstadt in LaTeX.
Therefore it contains documentclasses as well as some helper packages and config files together with some templates for user documentation, which currently are only available in German.

If you are not a German speaker and require some help using these files, please feel free to contact the maintainers.
 
## Includes templates and document types

document type | name of template file | used documentclass and config
------------- | ----------------- | ----------------
scientific paper | DEMO-TUDaPub.tex, using DEMO-TUDaBibliography.bib | tudapub.cls and tudasize9pt.clo
theses | DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, using DEMO-TUDaBibliography.bib | tudapub.cls and tudathesis.cfg
scientific poster | DEMO-TUDaSciPoster.tex | tudasciposter.cls
announcement poster | DEMO-TUDaPoster.tex | tudaposter.cls
presentation | DEMO-TUDaBeamer.tex | tudaposter.cls
letter | DEMO-TUDaLetter.tex, using DEMO-TUDaFromaddress.lco  | tudaletter.cls and tudalettersize10pt.clo

# Version History 

 * v1.00 First official version - published on 2019-07-20
 * v1.01 (2019-08-05) Smaller Layout Fixes and documentation enhancements 