--adding clicks column
alter table digital_marketing_campaign_dataset
add clicks int;

update digital_marketing_campaign_dataset
set clicks= Conversion*100/ConversionRate;


--adding column named impressions
alter table digital_marketing_campaign_dataset
add impressions int;

update digital_marketing_campaign_dataset
set impressions =clicks/ClickThroughRate;


--CampaignChannel by their invest and income
select CampaignChannel, round(sum(AdSpend),2) total_spend, round(sum(Income),2) total_income
from digital_marketing_campaign_dataset
group by CampaignChannel;


--CampaignType by their invest and income
select CampaignType, round(sum(AdSpend),2) total_spend, round(sum(Income),2) total_income
from digital_marketing_campaign_dataset
group by CampaignType;




--opt out rate
select CampaignType,(sum(EmailClicks)*100/sum(EmailOpens)) opt_out_rate
from digital_marketing_campaign_dataset
group by CampaignType;


--engagement rate
select CampaignType ,(sum(SocialShares)+sum(EmailOpens)+sum(EmailClicks))/sum(Conversion) engagement_rate
from digital_marketing_campaign_dataset
group by CampaignType;


--Channel performance
select campaignchannel,sum(impressions) impressions,sum(Conversion) conversion,round(sum(ClickThroughRate),2) ctr
from digital_marketing_campaign_dataset
group by CampaignChannel;


-- how many campaign had done
select CampaignType, count(CampaignChannel) no_of_campaigns
from digital_marketing_campaign_dataset
group by CampaignType;


--average loyalty points by campaignType
select CampaignChannel,avg(LoyaltyPoints) average_loyalty
from digital_marketing_campaign_dataset
group by CampaignChannel;


--campaign shares rate
select CampaignType, sum(SocialShares)*100.0/(
select sum(SocialShares) from digital_marketing_campaign_dataset) social_shares_rate
from digital_marketing_campaign_dataset
group by CampaignType;


--CampaignChannel by convertion rate
select CampaignChannel,avg(ConversionRate) average_cr
from digital_marketing_campaign_dataset
group by CampaignChannel;


-- convertion rate in different  age group
select case
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-46'
when age between 46 and 55 then '46-55'
when age between 56 and 65 then '56-65'
when age>65 then '65+'
else 'unknown'
end as age_range,
avg(ConversionRate) average_cr
from digital_marketing_campaign_dataset
group by case
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-46'
when age between 46 and 55 then '46-55'
when age between 56 and 65 then '56-65'
when age>65 then '65+'
else 'unknown'end
order by average_cr desc;


-- channel with their clicks and email opens
select CampaignChannel, avg(EmailClicks) average_clicks, avg(EmailOpens) average_opens
from digital_marketing_campaign_dataset
group by CampaignChannel;


-- gender wise cr and also ctr
select Gender, round(avg(ConversionRate),4) cr,round(avg(ClickThroughRate),4) ctr
from digital_marketing_campaign_dataset
group by Gender;


--campaign with their total spend,cost per clicks and also other financial things
select CampaignChannel,avg(AdSpend) average_spend, avg(Income) average_income, round(sum(AdSpend)/sum(clicks),3) cpc
from digital_marketing_campaign_dataset
group by CampaignChannel;






select * from digital_marketing_campaign_dataset;