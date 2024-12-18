﻿&НаСервере
Процедура Заполнить()
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ВзаиморасчетыОстатки.Контрагент,
	                      |	ВзаиморасчетыОстатки.Валюта,
	                      |	ВзаиморасчетыОстатки.СуммаОстаток КАК СуммаОстаток
	                      |ИЗ
	                      |	РегистрНакопления.Взаиморасчеты.Остатки КАК ВзаиморасчетыОстатки
	                      |АВТОУПОРЯДОЧИВАНИЕ");
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = ТаблицаОстатков.Добавить();
		НоваяСтрока.Контрагент = Выборка.Контрагент;
		НоваяСтрока.Валюта = Выборка.Валюта;
		Если Выборка.СуммаОстаток > 0 Тогда
			НоваяСтрока.НашДолг = Выборка.СуммаОстаток;
		Иначе
			НоваяСтрока.ДолгНам = Выборка.СуммаОстаток * -1;
		КонецЕсли;	
	КонецЦикла
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Заполнить();
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОстатковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ПоказатьЗначение( ,ТаблицаОстатков.НайтиПоИдентификатору(ВыбраннаяСтрока).Контрагент);
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВыполнить()
	ТаблицаОстатков.Очистить();
	Заполнить();
КонецПроцедуры
