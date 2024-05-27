namespace Quiz.Task.Service.ResponseDtos
{
    public record StudySetDto(int Id, string StudySetName, DateTime CreateDate, UserDto User, List<CardDto> Cards);
    public record UserDto(int Id, string UserName, DateTime CreateDate, byte[] Image);
    public record CardDto(int Id, string Term, string Definition);
    public record ClassDto(int Id, string ClassName, DateTime CreateDate, string Description, UserDto User, int NumOfFolder, int NumOfMember);
    public record MemberDto(int Id, ClassDto Class, UserDto Member);
    public record FolderDto(int Id, string FolderName, DateTime CreateDate, UserDto User, ClassDto Class, List<FolderDetailDto> FolderDetails);
    public record FolderDetailDto(int Id, int FolderId, int StudySetId);
}