-- 1. What grades are stored in the database?
SELECT Name from Grade;

-- 2. What emotions may be associated with a poem?
SELECT Name from Emotion;

-- 3. How many poems are in the database?
SELECT Count(Id) as 'Total Poem Count' FROM Poem;

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 Name FROM Author ORDER BY Name;

-- 5. Starting with the above query, add the grade of each of the authors.
SELECT 
	TOP 76 a.Name,
	g.Name
FROM Author a
JOIN Grade g on a.GradeId = g.Id
ORDER BY a.Name;

-- 6. Starting with the above query, add the recorded gender of each of the authors.
SELECT 
	TOP 76 a.Name,
	gen.Name,
	g.Name
FROM Author a
JOIN Grade g on a.GradeId = g.Id
JOIN Gender gen on a.GenderId = gen.Id
ORDER BY a.Name;

-- 7. What is the total number of words in all poems in the database?
SELECT Count(WordCount) FROM Poem;

-- 8. Which poem has the fewest characters?
SELECT Title, CharCount FROM Poem Where CharCount = (SELECT MIN(CharCount) FROM Poem);

-- 9. How many authors are in the third grade?
SELECT Count(Id) from Author;

-- 10. How many authors are in the first, second or third grades?
SELECT Count(author.Id) as AuthorCount, grade.Name
	FROM Author author
	JOIN Grade grade on author.GradeId = grade.Id
	WHERE grade.Name = '1st Grade' OR grade.Name = '2nd Grade' OR grade.Name = '3rd Grade'
	GROUP BY grade.Name;

-- 11. What is the total number of poems written by fourth graders?
SELECT 
	g.Name,
	Count(p.Id) as PoemCount
	FROM Poem p
	JOIN Author a on p.AuthorId = a.Id
	JOIN Grade g on a.GradeId = g.Id
	WHERE g.Name = '4th Grade'
	GROUP BY g.Name;

-- 12. How many poems are there per grade?
SELECT
	g.Name,
	Count(p.Id) as PoemCountPerGrade
	FROM Poem p
	JOIN Author a on p.AuthorId = a.Id
	JOIN Grade g on a.GradeId = g.Id
	GROUP BY g.Name;

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT
	g.Name,
	Count(a.Id) as AuthorCountPerGrade
	FROM Author a
	JOIN Grade g on a.GradeId = g.Id
	GROUP BY g.Name;

-- 14. What is the title of the poem that has the most words?
SELECT TOP 1
	LEN(p.Title) as TitleLength,
	p.Title
	FROM Poem p
	ORDER BY LEN(p.Title) DESC, p.Title;

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 3
	a.Name,
	Count(p.Id) as PoemCount
	FROM Author a
	JOIN Poem p on p.AuthorId = a.Id
	GROUP BY a.Name
	ORDER BY PoemCount DESC;

-- 16. How many poems have an emotion of sadness?
SELECT
	p.Title,
	e.Name,
	Count(p.Id) as PoemCount
	FROM Poem p
	JOIN PoemEmotion pe on pe.PoemId = p.Id
	JOIN Emotion e on e.Id = pe.EmotionId
	WHERE e.Name = Sadness;
	
