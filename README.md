# hse21_H3K9me3_ZDNA_human

Организм: human.

Гистоновая метка: H3K9me3.

Тип клеток: A549.

ChIP-seq эксперименты:
- https://www.encodeproject.org/files/ENCFF444EWQ/
- https://www.encodeproject.org/files/ENCFF811QUJ/

## 1. Анализ пиков гистоновой метки.

Построим гистограммы распределения длин участков для каждого из экспериментов (ENCFF444EWQ, ENCFF811QUJ) до и после конвертации из версии генома hg38 в hg19.

### 1.1. Эксперимент ENCFF444EWQ

- версия генома hg38
![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.H3K9me3_A549.ENCFF444EWQ.hg38.png)

- после конвертации в версию генома hg19
![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.H3K9me3_A549.ENCFF444EWQ.hg19.png)

### 1.2. Эксперимент ENCFF811QUJ

- версия генома hg38
![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.H3K9me3_A549.ENCFF811QUJ.hg38.png)

- после конвертации в версию генома hg19
![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.H3K9me3_A549.ENCFF811QUJ.hg19.png)

### 1.3. Вывод

Гистограммы длин пиков не поменялись, никаких аномалий не произошло, поэтому можно переходить к следующим шагам.

Команды:

```bash
liftOver H3K9me3_A549.ENCFF444EWQ.hg38.bed hg38ToHg19.over.chain.gz H3K9me3_A549.ENCFF444EWQ.hg19.bed H3K9me3_A549.ENCFF444EWQ.unmapped.bed
liftOver H3K9me3_A549.ENCFF811QUJ.hg38.bed hg38ToHg19.over.chain.gz H3K9me3_A549.ENCFF811QUJ.hg19.bed H3K9me3_A549.ENCFF811QUJ.unmapped.bed
```

## 2. Удаление длинных участков

Для каждого из экспериментов удалим пики, которые имеют длину (> 5000). Снова нарисуем гистограммы распределения длин участков.

### 2.1. Эксперимент ENCFF444EWQ

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/filter_peaks.H3K9me3_A549.ENCFF444EWQ.hg19.filtered.hist.png)

### 2.2. Эксперимент ENCFF811QUJ

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/filter_peaks.H3K9me3_A549.ENCFF811QUJ.hg19.filtered.hist.png)

## 3. Анализ расположения участков

Посмотрим, где располагаются пики гистоновой метки относительно аннотированных генов. Для этого построим pie-chart с помощью R-библиотеки ChIPseeker. 

### 3.1. Эксперимент ENCFF444EWQ

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/chip_seeker.H3K9me3_A549.ENCFF444EWQ.hg19.filtered.plotAnnoPie.png)

### 3.2. Эксперимент ENCFF811QUJ

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/chip_seeker.H3K9me3_A549.ENCFF811QUJ.hg19.filtered.plotAnnoPie.png)

## 4. Анализ участков вторичной структуры ДНК

### 4.1. Гистограмма распределения длин участков

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.DeepZ.png)

### 4.2. Расположение относительно аннотированных генов

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/chip_seeker.DeepZ.plotAnnoPie.png)

## 5. Анализ пересечения гистоновой метки и вторичной структуры ДНК.

Построим объединение участков из экспериментов ENCFF444EWQ и ENCFF811QUJ. После этого построим пересечение с вторичной структурой ДНК.

### 5.1. Распределение длин участков для построенного пересечения

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/len_hist.H3K9me3_A549.intersect_with_DeepZ.png)

### 5.2. Расположение относительно аннотированных генов для построенного пересечения

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/chip_seeker.H3K9me3_A549.intersect_with_DeepZ.plotAnnoPie.png)

Команды:

```bash
cat *.filtered.bed | sort -k1,1 -k2,2n | bedtools merge > H3K9me3_A549.merge.hg19.bed
bedtools intersect -a DeepZ.bed -b H3K9me3_A549.merge.hg19.bed > H3K9me3_A549.intersect_with_DeepZ.bed
```

## 6. Визуализация в геномном браузере

Визуализируем в геномном браузере:

- эксперимент ENCFF444EWQ (название ENCFF444EWQ)
- эксперимент ENCFF811QUJ (название ENCFF811QUJ)
- вторичная структура ДНК (название DeepZ)
- объединение экспериментов (название ChIP_merge)
- пересечение со вторичной структурой ДНК (название intersect_with_DeepZ)

Ссылка на сессию в UCSC GenomeBrowser:  https://genome.ucsc.edu/s/isaf27/hse21_H3K9me3_ZDNA_human

Приведем два примера различных пересечений:

- Пересечение двух экспериментов, а также вторичной структуры ДНК. Его можно увидеть на гене ZNF585A, координаты chr19:37,657,445-37,672,018.

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/screen.intersection1.png)

- Пересечение объединения двух экспериментов и вторичной структуры ДНК. Его можно увидеть в межгенном пространстве, координаты chr1:2,787,757-2,788,245.

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/screen.intersection2.png)

## 7. Ассоциация с генами

С помощью R-библиотеки ChIPpeakAnno сделаем ассоциацию полученных пиков (в пересечении с вторичной структурой ДНК) с ближайшими генами.

Всего удалось проассоциировать 133 пика, получилось 92 уникальных гена.

Проведем GO-анализ для полученных уникальных генов при помощи сайта http://pantherdb.org/. Получаем следующий список категорий:

![alt text](https://github.com/isaf27/hse21_H3K9me3_ZDNA_human/blob/main/images/go-analysis.png)
