--What grades are stored in the database?
SELECT *
FROM Grade;

--What emotions may be associated with a poem?
SELECT *
FROM Emotion;
--How many poems are in the database?
SELECT
COUNT(Id) AS 'Number of Poems'
FROM POEM;

--Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76
Name
FROM AUTHOR
ORDER BY Name ASC;

--Starting with the above query, add the grade of each of the authors.
SELECT TOP 76
a.Name AS 'Name',
g.Name AS 'Grade'
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
ORDER BY a.Name ASC;

--Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76
	a.Name AS 'Name',
	g.Name AS 'Grade',
	gen.Name as 'Gender'
FROM Author a
LEFT JOIN Grade g ON a.GradeId = g.Id
LEFT JOIN Gender gen ON a.GenderId = gen.Id
ORDER BY a.Name ASC;

--What is the total number of words in all poems in the database?
SELECT
SUM(WordCount) AS 'Total Word Count'
FROM Poem;

--Which poem has the fewest characters?
SELECT TOP 1
	CharCount
FROM Poem
ORDER BY CharCount DESC;

--How many authors are in the third grade?
SELECT COUNT(a.id) AS 'Number of Third Graders',
g.Name
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name = '3rd Grade'
GROUP BY g.Name;

--How many total authors are in the first through third grades?
SELECT COUNT(a.id) AS 'Number of 1st through 3rd Graders'
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name = '3rd Grade' OR g.Name = '2nd Grade' OR g.Name = '1st Grade';

--What is the total number of poems written by fourth graders?
SELECT COUNT(p.id) AS 'Number of Poems by 4th Graders'
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name = '4th Grade';

--How many poems are there per grade?
SELECT COUNT(p.id) AS 'Number of Poems By Grade',
g.Name
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name ASC;

--13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.id) AS 'Number of Authors By Grade',
g.Name
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name ASC;

--14 What is the title of the poem that has the most words?
SELECT TOP 1
	Title
FROM Poem
ORDER BY WordCount DESC;

--15 Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 5
	a.Name,
	COUNT(p.Id) AS '# of Poems'
FROM Author a
LEFT JOIN Poem p
ON p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY '# of Poems' DESC;

--16 How many poems have an emotion of sadness?
SELECT COUNT(e.Name) AS 'Number of Sad Poems'
FROM Emotion e
JOIN PoemEmotion pe
ON e.Id = pe.EmotionId
JOIN Poem p
ON pe.PoemId = p.Id
WHERE e.Name = 'sadness'
GROUP BY e.Name;

--17 How many poems are not associated with any emotion?
SELECT COUNT(p.Id) as 'Number of Emotionless Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe
ON p.Id = pe.PoemId
WHERE pe.EmotionId IS NULL;

--18 Which emotion is associated with the least number of poems?
SELECT TOP 2 e.Name, COUNT(p.Id) AS 'Number of Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe
ON pe.PoemId = p.Id
LEFT JOIN Emotion e
ON pe.EmotionId = e.Id
GROUP BY e.Name
ORDER BY 'Number of Poems';

--19 Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1
	g.name AS 'Grade',
	COUNT(p.id) AS 'Number of Joyful Poems',
	e.Name AS 'Emotion'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON pe.EmotionId = e.Id
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g ON a.GradeId = g.Id
WHERE e.Name = 'joy'
GROUP BY g.Name, e.Name
ORDER BY 'Number of Joyful Poems' DESC;


--20 Which gender has the least number of poems with an emotion of fear?

SELECT TOP 1
	g.name AS 'Gender',
	COUNT(p.id) AS 'Number of Fearful Poems',
	e.Name AS 'Emotion'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON pe.EmotionId = e.Id
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Gender g ON a.GenderId = g.Id
WHERE e.Name = 'joy'
GROUP BY g.Name, e.Name
ORDER BY 'Number of Fearful Poems' ASC;

--THURSDAY lightning exercise
-- How many authors are named "alice"?
SELECT
	Name,
	COUNT(Id) AS 'Total'
FROM Author
WHERE Name = 'alice'
GROUP BY Name;

-- find all the poems that contain the word "horse"
SELECT
	Title,
	Text
FROM Poem
WHERE Text LIKE '%horse%';