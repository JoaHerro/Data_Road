# The Analysis

## 1. What are The Most Top 3 skills on demand for The Top 3 Most popular jobs


View my notebook here:
[02_Skills_Counting.ipynb](
03_Project\02_Skills_Counting.ipynb)

## Visualize Data

```python

df_skills_count = df_skills_count.reset_index(name='skill_count')

df_skills_count

job_titles = df_skills_count['job_title_short'].unique().tolist()

job_titles = sorted(job_titles[:3])

job_titles

fig, ax = plt.subplots(len(job_titles), 1)

sns.set_theme(style='ticks')

for i, job_title in enumerate(job_titles):
    df_plot = df_skill_percentage[df_skill_percentage['job_title_short'] == job_title].head(5)
    #df_plot.plot(kind='barh', x='job_skills', y='skill_percentage', ax=ax[i], title=job_title)
    sns.barplot(data=df_plot, x='skill_percentage', y='job_skills', ax=ax[i], hue='skill_count', palette='dark:b_r')
    ax[i].set_title(job_title)
    ax[i].set_ylabel('')
    ax[i].set_xlabel('')
    ax[i].get_legend().remove()
    ax[i].set_xlim(0, 82)

    for n, v in enumerate(df_plot['skill_percentage']):
        ax[i].text(v+1, n, f'{v:.1f}%', va='center')

    if i != len(job_titles) - 1:
        ax[i].set_xticks([])

#plt.tight_layout()
fig.suptitle('Likelihood of Skills Requested in US Job Postings', fontsize=15)
plt.tight_layout(h_pad=0.5)
plt.show()
```

### Results

![](03_Project\Graphs\Top_3_skills_for_Top_3_jobs.png)