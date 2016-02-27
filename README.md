mixed-case-operator
===================

Description
-----------

A simple operator in the same spirit of |gu| and |gU| operators that makes the
text is operates on mixed case (or title case). The operator tries to be
somewhat smart about how it does the mix casing with special attention for
apostrophes in word like don't and tom's

Example of Mix Casing:

    that's a cool hat

Becomes:

    That's A Cool Hat


Usage
-----
| Mode   | Default Key | Description                       |
| ------ | ----------- | --------------------------------- |
| normal | gM{motion}  | Make {motion} text mixed case.    |
| normal | gMM         | Make current line mixed case.     |
| visual | {Visual}gM  | Make highlighted text mixed case. |
