/*Challenge Deliverable part 2 */
-- Step 1 retrieve all the rows where the total_votes count is equal to or greater than 20
select *
into morevotes_vine_table
from vine_table
where total_votes >= 20

-- Step 2 retrieve all the rows where the number of helpful_votes divided by total_votes 
--is equal to or greater than 50%
select *
into halfHelpful_vine_table
from morevotes_vine_table
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5

--Step 3 Retrieves all the rows where a review was written as part of the Vine program (paid),
--vine == 'Y' 
select *
into vineReviews_vine_table
from halfHelpful_vine_table
where vine = 'Y'
--Step 4 Retrieve all the rows where the review was not part of the Vine program (unpaid),
--vine == 'N'
select *
into notVineReviews_vine_table
from halfHelpful_vine_table
where vine = 'N'
--Determine: the total number of reviews, 
--	the number of 5-star reviews
--	the percentage of 5-star reviews 
-- ...for the two types of review (paid vs unpaid).
select (select count(*) from vineReviews_vine_table y) as totalVine,
		(select count(*) from notVineReviews_vine_table n) as totalNotVine,
		(select count(*) from vineReviews_vine_table y where star_rating=5) as totalVine5Star,
		(select count(*) from notVineReviews_vine_table n where star_rating=5) as totalNotVine5Star
into totalReviews_vine_table

--Add columns for percentages
Alter table totalReviews_vine_table Add column percentVine5Star float(24);
update totalReviews_vine_table set percentVine5Star = (totalVine5Star/totalVine::float)*100;
Alter table totalReviews_vine_table Add column percentNotVine5Star float(24);
update totalReviews_vine_table set percentNotVine5Star = (totalNotVine5Star/totalNotVine::float)*100;

select *
from totalReviews_vine_table


