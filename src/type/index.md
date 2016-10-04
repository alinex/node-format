Formats
============================================================

This configuration class allows multiple formats to be used.

The following table will give a short comparison.

|  Format | Readable | Comments | Arrays | Deep | Calc | Ref. |
|:--------|:--------:|:--------:|:------:|:----:|:----:|:----:|
| JSON    |    ++    |     no   |   yes  |  yes |   no |   no |
| JS      |    ++    |  allow   |   yes  |  yes | read |   no |
| CSON    |   +++    |  allow   |   yes  |  yes |   no |   no |
| Coffee  |   +++    |  allow   |   yes  |  yes | read |   no |
| YAML    |   +++    |  allow   |   yes  |  yes |   no | read |
| INI     |    ++    |  allow   |   yes  |  yes |   no |   no |
| Properties | ++    |  allow   |   yes  |  yes |   no | read |
| XML     |     +    |  allow   |   yes  |  yes |   no |   no |
| BSON    |    --    |     no   |   yes  |  yes |   no |   no |
| CSV     |     +    |    (no)  |   yes  | (yes)|   no |   no |

Legend: +++ to --- = good to bad; no = not possible; allow = allowed but unused;
read = only red but not written; write = only written but not red; yes = fully
supported; ? = unknown

See details for each format below.

Some of the formats support comments but they won't read or write them, they
only will allow them to be there in the file.
